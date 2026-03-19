import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart' as sqlite;

import 'package:innenkompass/data/db/app_database.dart';

void main() {
  test('migrates schema version 1 entries to version 5 without data loss',
      () async {
    final tempDir = await Directory.systemTemp.createTemp(
      'innenkompass_migration_test',
    );
    addTearDown(() async {
      if (tempDir.existsSync()) {
        await tempDir.delete(recursive: true);
      }
    });

    final dbFile = File(p.join(tempDir.path, 'innenkompass_v1.sqlite'));
    final seededDb = sqlite.sqlite3.open(dbFile.path);
    final nowSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    seededDb.execute('PRAGMA user_version = 1;');
    seededDb.execute('''
      CREATE TABLE situation_entries (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        situation_description TEXT NOT NULL,
        context TEXT NOT NULL,
        timestamp INTEGER NOT NULL,
        involved_person TEXT,
        intensity INTEGER NOT NULL,
        body_tension INTEGER NOT NULL,
        primary_emotion TEXT NOT NULL,
        secondary_emotion TEXT,
        body_symptoms TEXT,
        automatic_thought TEXT NOT NULL,
        first_impulse TEXT NOT NULL,
        actual_behavior TEXT,
        system_state TEXT NOT NULL,
        is_crisis INTEGER NOT NULL DEFAULT 0,
        intervention_type TEXT,
        intervention_id TEXT,
        intervention_completed INTEGER NOT NULL DEFAULT 0,
        intervention_duration_sec INTEGER,
        post_intensity INTEGER,
        post_body_tension INTEGER,
        post_clarity INTEGER,
        helpfulness_rating INTEGER,
        post_note TEXT,
        created_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now')),
        updated_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now')),
        is_draft INTEGER NOT NULL DEFAULT 0
      );
    ''');
    seededDb.execute('''
      CREATE TABLE user_settings (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        onboarding_completed INTEGER NOT NULL DEFAULT 0,
        is_first_launch INTEGER NOT NULL DEFAULT 1,
        locale TEXT NOT NULL DEFAULT 'de',
        notifications_enabled INTEGER NOT NULL DEFAULT 0,
        notification_times TEXT,
        discrete_notifications INTEGER NOT NULL DEFAULT 1,
        app_lock_enabled INTEGER NOT NULL DEFAULT 0,
        app_lock_type TEXT,
        theme_mode TEXT NOT NULL DEFAULT 'system',
        emergency_contacts TEXT,
        analytics_enabled INTEGER NOT NULL DEFAULT 0,
        last_backup_at INTEGER,
        last_data_cleanup_at INTEGER,
        created_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now')),
        updated_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now'))
      );
    ''');
    seededDb.execute('''
      CREATE TABLE crisis_plan (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        warning_signs TEXT,
        coping_strategies TEXT,
        social_support TEXT,
        safe_environment TEXT,
        professional_resources TEXT,
        emergency_contacts TEXT,
        local_resources TEXT,
        personal_motivation TEXT,
        created_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now')),
        updated_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now'))
      );
    ''');
    seededDb.execute('''
      INSERT INTO situation_entries (
        situation_description,
        context,
        timestamp,
        intensity,
        body_tension,
        primary_emotion,
        automatic_thought,
        first_impulse,
        system_state,
        created_at,
        updated_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
    ''', [
      'Streit nach einem Meeting',
      'Arbeit',
      nowSeconds,
      8,
      7,
      'Wut',
      'Ich werde nicht ernst genommen.',
      'Direkt zurückschreiben',
      'activated',
      nowSeconds,
      nowSeconds,
    ]);
    seededDb.dispose();

    final database = AppDatabase.forTesting(NativeDatabase(dbFile));
    addTearDown(database.close);

    final columns = await database
        .customSelect('PRAGMA table_info(situation_entries);')
        .get();
    final columnNames = columns
        .map((row) => row.data['name'] as String)
        .toList(growable: false);

    expect(columnNames, contains('need_or_wounded_point'));
    expect(columnNames, contains('next_step'));
    expect(columnNames, contains('fact_interpretation_result'));
    expect(columnNames, contains('evaluation_headline_key'));
    expect(columnNames, contains('evaluation_meaning_key'));
    expect(columnNames, contains('suggested_tip_ids'));
    expect(columnNames, contains('suggested_next_action_key'));
    expect(columnNames, contains('selected_next_action_key'));
    expect(columnNames, contains('ai_evaluation_status'));
    expect(columnNames, contains('ai_evaluation_provider'));
    expect(columnNames, contains('ai_evaluation_model'));
    expect(columnNames, contains('ai_evaluation_requested_at'));
    expect(columnNames, contains('ai_evaluation_completed_at'));
    expect(columnNames, contains('ai_evaluation_consent_given'));
    expect(columnNames, contains('ai_evaluation_text'));
    expect(columnNames, contains('ai_evaluation_schema_version'));
    expect(columnNames, contains('pre_trigger_preoccupation'));
    expect(columnNames, contains('problem_timing'));
    expect(columnNames, contains('trigger_description'));
    expect(columnNames, contains('pre_trigger_load'));
    expect(columnNames, contains('initial_body_reactions'));
    expect(columnNames, contains('additional_emotions'));
    expect(columnNames, contains('thought_focus'));
    expect(columnNames, contains('system_reaction'));
    expect(columnNames, contains('thought_patterns'));
    expect(columnNames, contains('actual_behavior_tags'));
    expect(columnNames, contains('tipping_point_awareness'));
    expect(columnNames, contains('touched_themes'));
    expect(columnNames, contains('needed_supports'));
    expect(columnNames, contains('realistic_alternative'));
    expect(columnNames, contains('trigger_as_last_drop'));
    expect(columnNames, contains('background_theme'));
    expect(columnNames, contains('pattern_familiarity'));
    expect(columnNames, contains('evaluation_helpful_now_key'));
    expect(columnNames, contains('evaluation_learning_point_key'));
    expect(columnNames, contains('evaluation_status_keys'));

    final upgradedEntry = await database.getSituationEntryById(1);
    expect(upgradedEntry, isNotNull);
    expect(upgradedEntry!.situationDescription, 'Streit nach einem Meeting');
    expect(upgradedEntry.context, 'Arbeit');
    expect(upgradedEntry.primaryEmotion, 'Wut');
    expect(upgradedEntry.needOrWoundedPoint, isNull);
    expect(upgradedEntry.nextStep, isNull);
    expect(upgradedEntry.factInterpretationResult, isNull);
    expect(upgradedEntry.evaluationHeadlineKey, isNull);
    expect(upgradedEntry.evaluationMeaningKey, isNull);
    expect(upgradedEntry.suggestedTipIds, isNull);
    expect(upgradedEntry.suggestedNextActionKey, isNull);
    expect(upgradedEntry.selectedNextActionKey, isNull);
    expect(upgradedEntry.aiEvaluationStatus, isNull);
    expect(upgradedEntry.aiEvaluationProvider, isNull);
    expect(upgradedEntry.aiEvaluationModel, isNull);
    expect(upgradedEntry.aiEvaluationRequestedAt, isNull);
    expect(upgradedEntry.aiEvaluationCompletedAt, isNull);
    expect(upgradedEntry.aiEvaluationConsentGiven, isFalse);
    expect(upgradedEntry.aiEvaluationText, isNull);
    expect(upgradedEntry.aiEvaluationSchemaVersion, isNull);
    expect(upgradedEntry.preTriggerPreoccupation, isNull);
    expect(upgradedEntry.thoughtFocus, isNull);
    expect(upgradedEntry.systemReaction, isNull);
    expect(upgradedEntry.realisticAlternative, isNull);
    expect(upgradedEntry.evaluationHelpfulNowKey, isNull);
    expect(upgradedEntry.evaluationLearningPointKey, isNull);
    expect(upgradedEntry.evaluationStatusKeys, isNull);

    final updated = upgradedEntry.copyWith(
      needOrWoundedPoint: const Value('Ich brauche Abstand.'),
      nextStep: const Value('Ich antworte spaeter ruhiger.'),
    );
    final writeResult = await database.updateSituationEntry(updated);
    expect(writeResult, isTrue);

    final rewrittenEntry = await database.getSituationEntryById(1);
    expect(rewrittenEntry, isNotNull);
    expect(rewrittenEntry!.needOrWoundedPoint, 'Ich brauche Abstand.');
    expect(rewrittenEntry.nextStep, 'Ich antworte spaeter ruhiger.');

    final versionRow =
        await database.customSelect('PRAGMA user_version;').getSingle();
    expect(versionRow.data['user_version'], 5);
  });
}
