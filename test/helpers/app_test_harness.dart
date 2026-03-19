import 'dart:convert';
import 'dart:ui';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:innenkompass/app/app.dart';
import 'package:innenkompass/application/providers/app_providers.dart';
import 'package:innenkompass/application/providers/bootstrap_provider.dart';
import 'package:innenkompass/application/providers/database_provider.dart';
import 'package:innenkompass/application/providers/evaluation_providers.dart';
import 'package:innenkompass/application/providers/lock_provider.dart';
import 'package:innenkompass/application/providers/settings_provider.dart';
import 'package:innenkompass/core/constants/intervention_types.dart';
import 'package:innenkompass/core/constants/system_states.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/domain/models/evaluation.dart';

class TestAppHarness {
  TestAppHarness({
    required this.container,
    required this.database,
  });

  final ProviderContainer container;
  final AppDatabase database;

  GoRouter get router => container.read(routerProvider);

  Future<void> goTo(WidgetTester tester, String location) async {
    router.go(location);
    await tester.pump();
    await tester.pumpAndSettle();
  }
}

Future<TestAppHarness> pumpTestApp(
  WidgetTester tester, {
  AppDatabase? database,
  bool onboardingCompleted = true,
  bool lockEnabled = false,
  bool isLocked = false,
}) async {
  await tester.binding.setSurfaceSize(const Size(800, 1600));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  final resolvedDatabase =
      database ?? AppDatabase.forTesting(NativeDatabase.memory());
  addTearDown(resolvedDatabase.close);

  await resolvedDatabase.getOrCreateCrisisPlan();
  final settings = await _seedSettings(
    resolvedDatabase,
    onboardingCompleted: onboardingCompleted,
    lockEnabled: lockEnabled,
  );

  final lockType = lockEnabled ? 'pin' : null;
  final snapshot = AppBootstrapSnapshot(
    settings: settings,
    isLockEnabled: lockEnabled,
    lockType: lockType,
  );

  final container = ProviderContainer(
    overrides: [
      databaseProvider.overrideWithValue(resolvedDatabase),
      appBootstrapProvider.overrideWith((ref) async => snapshot),
      evaluationContentProvider.overrideWith(
        (ref) async => EvaluationContentBundle.fallback,
      ),
    ],
  );
  addTearDown(container.dispose);

  container.read(settingsNotifierProvider.notifier).hydrate(settings);
  container.read(lockStateProvider.notifier).hydrate(
        isEnabled: lockEnabled,
        lockType: lockType,
      );
  if (!isLocked) {
    container.read(lockStateProvider.notifier).unlock();
  }

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const InnenkompassApp(),
    ),
  );
  await tester.pump();
  await tester.pumpAndSettle();

  return TestAppHarness(
    container: container,
    database: resolvedDatabase,
  );
}

Future<UserSettingsData> _seedSettings(
  AppDatabase database, {
  required bool onboardingCompleted,
  required bool lockEnabled,
}) async {
  final current = await database.getOrCreateUserSettings();
  final now = DateTime.now();
  final updated = current.copyWith(
    onboardingCompleted: onboardingCompleted,
    isFirstLaunch: !onboardingCompleted,
    appLockEnabled: lockEnabled,
    appLockType: lockEnabled ? const Value('pin') : const Value(null),
    updatedAt: now,
  );
  await database.updateUserSettings(updated);
  return updated;
}

Future<int> insertSituationEntry(
  AppDatabase database, {
  DateTime? timestamp,
  String situationDescription =
      'Ein angespanntes Meeting ist plötzlich gekippt.',
  String context = 'work',
  String involvedPerson = 'Kollege',
  int intensity = 7,
  int bodyTension = 8,
  String primaryEmotion = 'fear',
  String? secondaryEmotion = 'shame',
  List<String> bodySymptoms = const ['Enge in der Brust', 'Zittern'],
  String automaticThought = 'Ich werde jetzt sicher falsch verstanden.',
  String firstImpulse = 'withdraw',
  String factInterpretationResult = 'mixed',
  String actualBehavior = 'Ich habe erst einmal nichts geantwortet.',
  String needOrWoundedPoint = 'Ich will ernst genommen werden.',
  String nextStep = 'Ich notiere zuerst die Fakten.',
  String systemState = 'interpretation',
  bool isCrisis = false,
  String evaluationHeadlineKey = 'reflective_ready',
  String evaluationMeaningKey = 'reflective_ready_accessible',
  List<String> suggestedTipIds = const [
    'check_facts_not_assumptions',
    'write_alternative_explanation',
  ],
  String suggestedNextActionKey = 'choose_one_step',
  String? selectedNextActionKey,
  String? interventionType,
  String? aiEvaluationStatus,
  DateTime? aiEvaluationRequestedAt,
  bool aiEvaluationConsentGiven = false,
}) {
  final now = timestamp ?? DateTime(2026, 3, 19, 10, 0);

  return database.createSituationEntry(
    SituationEntriesCompanion.insert(
      situationDescription: situationDescription,
      context: context,
      timestamp: now,
      involvedPerson: Value(involvedPerson),
      intensity: intensity,
      bodyTension: bodyTension,
      primaryEmotion: primaryEmotion,
      secondaryEmotion: Value(secondaryEmotion),
      bodySymptoms: Value(jsonEncode(bodySymptoms)),
      automaticThought: automaticThought,
      firstImpulse: firstImpulse,
      factInterpretationResult: Value(factInterpretationResult),
      actualBehavior: Value(actualBehavior),
      needOrWoundedPoint: Value(needOrWoundedPoint),
      nextStep: Value(nextStep),
      systemState: systemState,
      isCrisis: Value(isCrisis),
      evaluationHeadlineKey: Value(evaluationHeadlineKey),
      evaluationMeaningKey: Value(evaluationMeaningKey),
      suggestedTipIds: Value(jsonEncode(suggestedTipIds)),
      suggestedNextActionKey: Value(suggestedNextActionKey),
      selectedNextActionKey: Value(selectedNextActionKey),
      interventionType: Value(
        interventionType ?? InterventionType.regulation.name,
      ),
      aiEvaluationStatus: Value(aiEvaluationStatus),
      aiEvaluationRequestedAt: Value(aiEvaluationRequestedAt),
      aiEvaluationConsentGiven: Value(aiEvaluationConsentGiven),
      isDraft: const Value(false),
    ),
  );
}

Future<int> insertCrisisQuickCheckinEntry(AppDatabase database) {
  return insertSituationEntry(
    database,
    intensity: 10,
    bodyTension: 10,
    primaryEmotion: 'fear',
    secondaryEmotion: null,
    bodySymptoms: const ['Herzrasen'],
    automaticThought: 'Ich halte das gerade nicht aus.',
    firstImpulse: 'freeze',
    factInterpretationResult: 'mostlyInterpretation',
    actualBehavior: 'Ich ziehe mich zurück.',
    needOrWoundedPoint: 'Ich brauche sofort Sicherheit.',
    nextStep: 'Ich hole mir Hilfe.',
    systemState: SystemState.crisis.name,
    isCrisis: true,
    interventionType: InterventionType.regulation.name,
  );
}
