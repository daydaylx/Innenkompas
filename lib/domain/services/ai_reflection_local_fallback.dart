import 'dart:convert';

import '../../core/constants/actual_behavior_types.dart';
import '../../data/db/app_database.dart';
import '../models/ai_reflection.dart';
import 'ai_reflection_service.dart';

class AiReflectionLocalFallback {
  AiReflectionLocalFallback._();

  static const provider = 'local_fallback';
  static const model = 'local_rules';
  static const schemaVersion = 1;

  static const transientErrorCodes = {
    AiReflectionErrorCode.timeout,
    AiReflectionErrorCode.network,
    AiReflectionErrorCode.unavailable,
    AiReflectionErrorCode.rateLimited,
    AiReflectionErrorCode.unauthorized,
    AiReflectionErrorCode.invalidResponse,
    AiReflectionErrorCode.unknown,
    AiReflectionErrorCode.disabled,
  };

  static bool shouldUseFallback(AiReflectionException error) {
    return transientErrorCodes.contains(error.code);
  }

  static AiReflectionStartState buildStartState({
    required SituationEntryData entry,
    required AiReflectionMode mode,
    required String sessionId,
    required String inputHash,
    required DateTime startedAt,
  }) {
    return AiReflectionStartState(
      sessionId: sessionId,
      inputHash: inputHash,
      provider: provider,
      model: model,
      schemaVersion: schemaVersion,
      startedAt: startedAt,
      content: AiReflectionStartContent(
        observation: _observationFor(entry, mode),
        question: _questionFor(entry, mode),
        helperStarters: _helperStartersFor(entry, mode),
      ),
    );
  }

  static AiReflectionResult buildResult({
    required SituationEntryData entry,
    required AiReflectionMode mode,
    required String userReply,
  }) {
    final summary = _summaryFor(
      entry: entry,
      mode: mode,
      userReply: userReply,
    );
    final likelyCore = _likelyCoreFor(entry, mode);
    final earlyTurningPoint = _earlyTurningPointFor(entry, mode);
    final alternative = _alternativeFor(entry, mode);
    final nextStep = _nextStepFor(entry, mode);
    final mantra = _mantraFor(entry, mode);

    return AiReflectionResult(
      summary: summary,
      likelyCore: likelyCore,
      earlyTurningPoint: earlyTurningPoint,
      alternative: alternative,
      nextStep: nextStep,
      mantra: mantra,
    );
  }

  static String _observationFor(
    SituationEntryData entry,
    AiReflectionMode mode,
  ) {
    final neededSupport = _primaryNeededSupport(entry);
    if (neededSupport != null &&
        mode != AiReflectionMode.stabilize &&
        mode != AiReflectionMode.organize) {
      return 'Im Eintrag fällt auf, dass nicht nur Anspannung da war, sondern auch etwas gefehlt hat: $neededSupport.';
    }
    if (mode == AiReflectionMode.stabilize ||
        entry.intensity >= 9 ||
        entry.bodyTension >= 9) {
      return 'Im Eintrag fällt vor allem die hohe Anspannung auf. Gerade wirkt Entlastung hilfreicher als tiefe Analyse.';
    }
    if ((entry.preTriggerLoad ?? 0) >= 7 &&
        (entry.triggerAsLastDrop == 'yes' ||
            entry.triggerAsLastDrop == 'partly')) {
      return 'Der Eintrag wirkt so, als wäre nicht nur der Auslöser belastend gewesen, sondern auch schon die Voranspannung davor.';
    }
    if ((entry.backgroundTheme ?? '').trim().isNotEmpty) {
      return 'Der Anlass wirkt eher wie ein sichtbarer Punkt in einem größeren Thema als wie das ganze Problem.';
    }
    return 'Der Eintrag zeigt bereits eine erkennbare Kette aus Anspannung, Reaktion und dem, was danach gefehlt hat.';
  }

  static String _questionFor(
    SituationEntryData entry,
    AiReflectionMode mode,
  ) {
    switch (mode) {
      case AiReflectionMode.understand:
        return 'Was war deiner Meinung nach schon vor dem eigentlichen Moment das größere Thema?';
      case AiReflectionMode.redirect:
        final realisticAlternative = entry.realisticAlternative?.trim();
        if (realisticAlternative != null && realisticAlternative.isNotEmpty) {
          return 'Du hast schon notiert: "$realisticAlternative". Was hätte dir geholfen, dort früher hinzukommen?';
        }
        return 'Welcher kleine Schritt wäre realistischer gewesen: kurz stoppen, Abstand schaffen, etwas sagen oder etwas anderes?';
      case AiReflectionMode.organize:
        return 'Soll ich dir daraus eher einen kurzen Lernsatz oder einen nächsten kleinen Schritt formulieren?';
      case AiReflectionMode.stabilize:
        return 'Was wäre gerade am ehesten machbar: Abstand, Wasser, kurze Bewegung, stille Pause oder sichere Person?';
    }
  }

  static List<String> _helperStartersFor(
    SituationEntryData entry,
    AiReflectionMode mode,
  ) {
    switch (mode) {
      case AiReflectionMode.understand:
        return const [
          'Ich glaube eher ...',
          'Eigentlich ging es darum ...',
          'Schon vorher war da ...',
        ];
      case AiReflectionMode.redirect:
        if ((entry.realisticAlternative ?? '').trim().isNotEmpty) {
          return const [
            'Geholfen hätte ...',
            'Früher merkbar wäre ...',
            'Dafür hätte ich gebraucht ...',
          ];
        }
        return const [
          'Realistisch wäre gewesen ...',
          'Ich hätte eher kurz ...',
          'Früher abbiegen hieß ...',
        ];
      case AiReflectionMode.organize:
        return const [
          'Eher ein Lernsatz ...',
          'Eher ein kleiner Schritt ...',
        ];
      case AiReflectionMode.stabilize:
        return const [
          'Am ehesten machbar ist ...',
          'Gerade hilft mir eher ...',
        ];
    }
  }

  static String _summaryFor({
    required SituationEntryData entry,
    required AiReflectionMode mode,
    required String userReply,
  }) {
    final replySentence = _replyMirrorSentence(
      mode: mode,
      userReply: userReply,
    );

    switch (mode) {
      case AiReflectionMode.stabilize:
        return [
          'Gerade zählt eher Entlastung als tiefes Verstehen.',
          if (replySentence != null) replySentence,
          'Hilfreicher als weiteres Kreisen ist jetzt ein kleiner, machbarer Stabilisierungsschritt.',
        ].join(' ');
      case AiReflectionMode.organize:
        return [
          _observationFor(entry, mode),
          if (replySentence != null) replySentence,
          'Wichtiger als perfektes Verstehen ist jetzt eine kurze, brauchbare Sortierung.',
        ].join(' ');
      case AiReflectionMode.redirect:
        return [
          _observationFor(entry, mode),
          if (replySentence != null) replySentence,
          'Die Veränderung setzt wahrscheinlich früher an als beim sichtbaren Endverhalten.',
        ].join(' ');
      case AiReflectionMode.understand:
        return [
          _observationFor(entry, mode),
          if (replySentence != null) replySentence,
          'Es spricht eher für eine Mischung aus Vorbelastung und aktuellem Auslöser als nur für eine einzelne Kleinigkeit.',
        ].join(' ');
    }
  }

  static String? _replyMirrorSentence({
    required AiReflectionMode mode,
    required String userReply,
  }) {
    final reply = _normalizeQuotedReply(userReply);
    if (reply == null) {
      return null;
    }

    switch (mode) {
      case AiReflectionMode.understand:
        return 'Du benennst als wichtiges Hintergrundthema: "$reply".';
      case AiReflectionMode.redirect:
        return 'Als realistische Abzweigung nennst du: "$reply".';
      case AiReflectionMode.organize:
        return 'Du hältst als knappe Sortierung fest: "$reply".';
      case AiReflectionMode.stabilize:
        return 'Gerade wirkt für dich am ehesten machbar: "$reply".';
    }
  }

  static String? _normalizeQuotedReply(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return null;
    }

    final collapsedWhitespace = trimmed.replaceAll(RegExp(r'\s+'), ' ');
    var normalized = collapsedWhitespace;
    while (normalized.isNotEmpty && _isQuoteCharacter(normalized[0])) {
      normalized = normalized.substring(1).trimLeft();
    }
    while (normalized.isNotEmpty &&
        _isQuoteCharacter(normalized[normalized.length - 1])) {
      normalized = normalized.substring(0, normalized.length - 1).trimRight();
    }
    normalized = normalized.replaceAll(RegExp(r'[.!?]+$'), '').trim();

    if (normalized.isEmpty) {
      return null;
    }

    return normalized;
  }

  static bool _isQuoteCharacter(String value) {
    return value == '"' ||
        value == '\'' ||
        value == '`' ||
        value == '“' ||
        value == '”' ||
        value == '„';
  }

  static String _likelyCoreFor(
    SituationEntryData entry,
    AiReflectionMode mode,
  ) {
    final neededSupport = _primaryNeededSupport(entry);
    if (mode == AiReflectionMode.stabilize) {
      return 'Wahrscheinlich ist gerade nicht mehr Analyse, sondern weniger Druck der hilfreichste Kern.';
    }
    if (neededSupport != null) {
      return 'Möglich ist, dass hier weniger nur der Auslöser, sondern eher das fehlende $neededSupport mitgewirkt hat.';
    }
    if ((entry.backgroundTheme ?? '').trim().isNotEmpty) {
      return 'Möglich ist, dass nicht nur der Auslöser, sondern auch ${entry.backgroundTheme!.trim()} mitgewirkt hat.';
    }
    if ((entry.preTriggerLoad ?? 0) >= 7) {
      return 'Wahrscheinlich haben Voranspannung und Auslöser zusammen gewirkt.';
    }
    if (entry.triggerAsLastDrop == 'yes' ||
        entry.triggerAsLastDrop == 'partly') {
      return 'Möglich ist, dass die Kleinigkeit eher der letzte Tropfen als das ganze Problem war.';
    }
    return 'Der Eintrag spricht eher für eine schnelle automatische Reaktion als für ein klar eingegrenztes Einzelproblem.';
  }

  static String _earlyTurningPointFor(
    SituationEntryData entry,
    AiReflectionMode mode,
  ) {
    if (mode == AiReflectionMode.stabilize) {
      return 'Der früheste Kipppunkt war vermutlich der Moment, in dem Körper und Spannung merklich hochgegangen sind.';
    }
    if ((entry.preTriggerLoad ?? 0) >= 7) {
      return 'Gekippt ist es wahrscheinlich schon, als der Kopf vorher voll war und die Reizbarkeit gestiegen ist.';
    }
    if (entry.tippingPointAwareness == 'early') {
      return 'Der Kipppunkt war schon früh merkbar. Dort lohnt sich eher eine bewusste Entscheidung als späteres Reparieren.';
    }
    if (entry.tippingPointAwareness == 'late') {
      return 'Der Kipppunkt war wohl mitten in der laufenden Eskalation merkbar. Dort braucht es eher eine kurze Unterbrechung als mehr Analyse.';
    }
    if (entry.tippingPointAwareness == 'afterwards' ||
        entry.tippingPointAwareness == 'none') {
      return 'Der früheste Kipppunkt war wahrscheinlich ein Körper- oder Spannungszeichen, das erst später klar wurde.';
    }
    if (entry.bodyTension >= 7) {
      return 'Ein früher Kipppunkt war wahrscheinlich der Moment, in dem die körperliche Anspannung deutlich hochging.';
    }
    if ((entry.tippingPointAwareness ?? '').trim().isNotEmpty) {
      return 'Der Kipppunkt lag wahrscheinlich kurz vor der ersten sichtbaren Reaktion, nicht erst beim Ende der Situation.';
    }
    return 'Der früheste Kipppunkt lag vermutlich kurz vor der automatischen Reaktion.';
  }

  static String _alternativeFor(
    SituationEntryData entry,
    AiReflectionMode mode,
  ) {
    final realisticAlternative = entry.realisticAlternative?.trim();
    if (realisticAlternative != null && realisticAlternative.isNotEmpty) {
      return realisticAlternative;
    }

    if (mode == AiReflectionMode.stabilize) {
      return 'Ein machbarer anderer Schritt ist gerade, kurz zu stoppen und zuerst den Körper zu beruhigen.';
    }

    final behaviors = ActualBehaviorTypes.labelsFor(
      ActualBehaviorTypes.normalizeAll(
          _decodeStringList(entry.actualBehaviorTags)),
    );
    if (behaviors.contains('laut geworden') ||
        behaviors.contains('geschrien')) {
      return 'Ein realistischer anderer Schritt wäre gewesen, kurz Abstand zu schaffen statt sofort weiter hochzugehen.';
    }
    if (behaviors.contains('zurückgezogen') ||
        behaviors.contains('blockiert')) {
      return 'Ein realistischer anderer Schritt wäre gewesen, kurz zu benennen, dass du einen Moment brauchst, statt ganz zuzumachen.';
    }

    return 'Ein realistischer anderer Schritt wäre gewesen, kurz zu stoppen und die Reaktion etwas zu verlangsamen.';
  }

  static String _nextStepFor(
    SituationEntryData entry,
    AiReflectionMode mode,
  ) {
    final nextStep = entry.nextStep?.trim();
    if (nextStep != null && nextStep.isNotEmpty) {
      return nextStep;
    }

    switch (mode) {
      case AiReflectionMode.stabilize:
        return 'Jetzt erst Abstand schaffen, den Körper regulieren und später mit mehr Ruhe wieder draufschauen.';
      case AiReflectionMode.organize:
        return 'Halte einen kurzen Lernsatz fest und lass es für heute dabei bewenden.';
      case AiReflectionMode.redirect:
        final realisticAlternative = entry.realisticAlternative?.trim();
        if (realisticAlternative != null && realisticAlternative.isNotEmpty) {
          return 'Notiere kurz, was dich früher zu "$realisticAlternative" gebracht hätte.';
        }
        return 'Notiere den frühesten Kipppunkt in einem Satz, damit du ihn nächstes Mal früher erkennst.';
      case AiReflectionMode.understand:
        return 'Schreibe in einem Satz auf, was wahrscheinlich das eigentliche Thema hinter dem Anlass war.';
    }
  }

  static String? _mantraFor(
    SituationEntryData entry,
    AiReflectionMode mode,
  ) {
    final neededSupport = _primaryNeededSupport(entry);
    if (mode == AiReflectionMode.stabilize) {
      return 'Erst runterkommen, dann sortieren.';
    }
    if (neededSupport != null) {
      return '$neededSupport zuerst, dann der Rest.';
    }
    if ((entry.preTriggerLoad ?? 0) >= 7 ||
        entry.triggerAsLastDrop == 'yes' ||
        entry.triggerAsLastDrop == 'partly') {
      return 'Wenn du schon voll bist, ist früheres Entlasten der eigentliche Schritt.';
    }
    return null;
  }

  static String? _primaryNeededSupport(SituationEntryData entry) {
    final decoded = _decodeStringList(entry.neededSupports);
    if (decoded.isEmpty) {
      return null;
    }
    return decoded.first.toLowerCase();
  }

  static List<String> _decodeStringList(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return const [];
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded
            .whereType<String>()
            .map((value) => value.trim())
            .where((value) => value.isNotEmpty)
            .toList(growable: false);
      }
    } catch (_) {
      return const [];
    }

    return const [];
  }
}
