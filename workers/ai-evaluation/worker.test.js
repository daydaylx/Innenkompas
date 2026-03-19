import assert from 'node:assert/strict';
import test from 'node:test';

import {
  buildModelInputPayload,
  buildRateLimitKey,
  corsHeaders,
  enforceRateLimit,
  isEvaluationPath,
  isReflectionPath,
  resolveAllowedOrigin,
  sanitizeEntry,
  validateReflection,
  validateReflectionRequest,
  validateRequest,
} from './worker.js';

test('isEvaluationPath accepts root and sub-path endpoints', () => {
  assert.equal(isEvaluationPath('/ai-evaluations'), true);
  assert.equal(isEvaluationPath('/v1/ai-evaluations'), true);
  assert.equal(isEvaluationPath('/v1/other'), false);
});

test('isReflectionPath accepts root and sub-path endpoints', () => {
  assert.equal(isReflectionPath('/ai-reflections'), true);
  assert.equal(isReflectionPath('/v1/ai-reflections'), true);
  assert.equal(isReflectionPath('/v1/other'), false);
});

test('validateRequest rejects oversized text payloads', () => {
  const error = validateRequest({
    consent_given: true,
    entry: {
      situation_description: 'x'.repeat(301),
      automatic_thought: 'Gedanke',
      first_impulse: 'withdraw',
    },
  });

  assert.equal(error, 'Entry description is too long');
});

test('validateReflectionRequest requires phase, mode and user reply for completion', () => {
  const missingReplyError = validateReflectionRequest({
    phase: 'complete',
    mode: 'understand',
    entry: {
      situation_description: 'Eintrag',
      automatic_thought: 'Gedanke',
      first_impulse: 'withdraw',
    },
  });

  assert.equal(missingReplyError, 'User reply is required');

  const validStart = validateReflectionRequest({
    phase: 'start',
    mode: 'redirect',
    entry: {
      situation_description: 'Eintrag',
      automatic_thought: 'Gedanke',
      first_impulse: 'withdraw',
    },
  });

  assert.equal(validStart, null);
});

test('sanitizeEntry trims free-text fields consistently', () => {
  const sanitized = sanitizeEntry({
    context: ' work ',
    situation_description: ' Situation ',
    involved_person: ' Kollege ',
    primary_emotion: ' fear ',
    secondary_emotion: ' shame ',
    body_symptoms: [' Zittern ', ' Enge in der Brust '],
    automatic_thought: ' Gedanke ',
    first_impulse: ' withdraw ',
    fact_interpretation_result: ' mostlyInterpretation ',
    actual_behavior: ' Noch nichts ',
    need_or_wounded_point: ' Ernst genommen werden ',
    next_step: ' Fakten notieren ',
    system_state: ' interpretation ',
    local_evaluation: {
      headline_key: ' interpretation_uncertain_facts ',
      meaning_key: ' interpretation_not_certain ',
      suggested_tip_ids: [' check_facts_not_assumptions '],
      suggested_next_action_key: ' check_facts_first ',
      selected_next_action_key: ' check_facts_first ',
    },
  });

  assert.equal(sanitized.first_impulse, 'withdraw');
  assert.equal(sanitized.fact_interpretation_result, 'mostlyInterpretation');
  assert.deepEqual(sanitized.body_symptoms, ['Zittern', 'Enge in der Brust']);
  assert.equal(
    sanitized.local_evaluation.suggested_next_action_key,
    'check_facts_first',
  );
});

test('buildModelInputPayload maps internal codes to readable hints', () => {
  const payload = buildModelInputPayload({
    context: 'work',
    situation_description: 'Nach einem schwierigen Meeting.',
    intensity: 7,
    body_tension: 8,
    primary_emotion: 'fear',
    secondary_emotion: 'shame',
    body_symptoms: [' Enge in der Brust '],
    automatic_thought: 'Ich werde falsch verstanden.',
    first_impulse: 'withdraw',
    fact_interpretation_result: 'mostlyInterpretation',
    next_step: 'Ich notiere erst die Fakten.',
    system_state: 'interpretation',
    local_evaluation: {
      headline_key: 'interpretation_uncertain_facts',
      meaning_key: 'interpretation_not_certain',
      suggested_tip_ids: ['check_facts_not_assumptions'],
      suggested_next_action_key: 'check_facts_first',
    },
  });

  assert.equal(payload.entry.context, 'Arbeit');
  assert.equal(payload.entry.primary_emotion, 'Angst');
  assert.equal(payload.entry.first_impulse, 'Rückziehen');
  assert.equal(payload.entry.fact_interpretation.label, 'Eher Interpretation');
  assert.equal(
    payload.entry.local_system_state_hint.label,
    'Interpretationsmodus',
  );
  assert.equal(
    payload.entry.local_evaluation_hints.suggested_next_action,
    'Fakten sammeln, bevor weiter gedeutet wird.',
  );
  assert.deepEqual(payload.entry.body_symptoms, ['Enge in der Brust']);
});

test('validateReflection normalizes start and completion payloads', () => {
  const startPayload = validateReflection({
    observation: ' Hohe Voranspannung vor dem Trigger. ',
    question: ' Was war vorher schon das grössere Thema? ',
    helper_starters: ['Ich glaube eher ...', 'Eigentlich ging es darum ...'],
  }, 'start');

  assert.equal(startPayload.observation, 'Hohe Voranspannung vor dem Trigger.');
  assert.equal(startPayload.question, 'Was war vorher schon das grössere Thema?');
  assert.deepEqual(startPayload.helper_starters, [
    'Ich glaube eher ...',
    'Eigentlich ging es darum ...',
  ]);

  const completePayload = validateReflection({
    summary: ' Nicht nur der Anlass war belastend. ',
    likely_core: ' Vorbelastung plus Trigger. ',
    early_turning_point: ' Als selbst kleine Dinge gereizt haben. ',
    alternative: ' Kurz stoppen statt direkt reagieren. ',
    next_step: ' Erst runterfahren und später neu ansehen. ',
    mantra: ' Voller Kopf plus Trigger. ',
  }, 'complete');

  assert.equal(completePayload.likely_core, 'Vorbelastung plus Trigger.');
  assert.equal(completePayload.mantra, 'Voller Kopf plus Trigger.');
});

test('corsHeaders only allows configured origins', () => {
  const request = new Request('https://worker.example/v1/ai-evaluations', {
    headers: {
      Origin: 'https://app.example.com',
    },
  });

  assert.equal(
    resolveAllowedOrigin(
      'https://app.example.com',
      'https://app.example.com, https://admin.example.com',
    ),
    'https://app.example.com',
  );
  assert.equal(
    corsHeaders(request, {})['Access-Control-Allow-Origin'],
    undefined,
  );
  assert.equal(
    corsHeaders(request, {
      CORS_ALLOWED_ORIGINS: 'https://app.example.com',
    })['Access-Control-Allow-Origin'],
    'https://app.example.com',
  );
});

test('enforceRateLimit blocks repeated requests within the same window', () => {
  const request = new Request('https://worker.example/ai-evaluations', {
    headers: {
      'CF-Connecting-IP': '203.0.113.10',
    },
  });
  const env = {
    RATE_LIMIT_MAX_REQUESTS: '2',
    RATE_LIMIT_WINDOW_SECONDS: '60',
  };

  const first = enforceRateLimit(request, env, 1_000);
  const second = enforceRateLimit(request, env, 1_500);
  const third = enforceRateLimit(request, env, 2_000);

  assert.equal(buildRateLimitKey(request), 'ip:203.0.113.10');
  assert.equal(first.allowed, true);
  assert.equal(second.allowed, true);
  assert.equal(third.allowed, false);
  assert.ok(third.retryAfterSeconds >= 1);
});
