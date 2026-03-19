# BUGLIST

## Kritisch
- [AUD-001] App-Lock-Bypass bei Start/Resume
  - Status: Bestätigt
  - Fundort: `lib/application/providers/app_providers.dart:30-47`, `lib/features/splash/screens/splash_screen.dart:27-43`, `lib/application/providers/lock_provider.dart:49-66`, `lib/app/app.dart:29-32`
  - Auswirkung: Sensitive Inhalte können trotz aktiviertem Lock ohne Authentifizierung sichtbar werden.

## Hoch
- [AUD-002] Notification-Settings werden nicht persistent geladen/gespeichert
  - Status: Bestätigt
  - Fundort: `lib/features/settings/widgets/notification_settings_section.dart:13-71`, `lib/application/providers/notification_provider.dart:43-94`
  - Auswirkung: Reminder-Konfiguration geht beim Neustart verloren.

- [AUD-003] Notification-Service wird nie initialisiert
  - Status: Bestätigt
  - Fundort: `lib/domain/services/notification_service.dart:20-37`, `lib/application/providers/notification_provider.dart:12-15`
  - Auswirkung: Scheduling und Plugin-Lifecycle sind nicht korrekt vorbereitet.

- [AUD-004] "Alle Daten löschen" löscht keine Daten
  - Status: Bestätigt
  - Fundort: `lib/features/settings/widgets/data_cleanup_button.dart:25-29,46-54`, `lib/application/providers/settings_provider.dart:97-104`
  - Auswirkung: Datenschutz- und Vertrauensbruch.

- [AUD-005] Settings-Updates hängen an `id == 1`
  - Status: Bestätigt
  - Fundort: `lib/data/dao/settings_dao.dart:17-75`, `lib/data/db/app_database.dart:141-167,201-207`
  - Auswirkung: Nach Datenlöschung oder Re-Insert können Settings-Updates stillschweigend ausfallen.

- [AUD-006] Erkannte Krisen führen nicht in den Krisen-Interventionspfad
  - Status: Bestätigt
  - Fundort: `lib/domain/services/classification_service.dart:45-80`, `lib/domain/rules/state_classifier.dart:25-75`, `lib/domain/rules/intervention_selector.dart:57-114`
  - Auswirkung: Im Krisenfall können unpassende Interventionen priorisiert werden.

- [AUD-007] `timestamp` und `createdAt` werden semantisch vermischt
  - Status: Bestätigt
  - Fundort: `lib/domain/services/pattern_analyzer.dart:23-29,115-119,141-145,216-218,319-323,450-453`, `lib/application/providers/intervention_providers.dart:343-347,375-376`, `lib/features/history/widgets/history_entry_card.dart:55-56`
  - Auswirkung: Verlauf und Musteranalyse werden bei rückdatierten Einträgen fachlich falsch.

- [AUD-008] SQLite-Dependency-Drift zwischen Root und Referenzkopie
  - Status: Hohe Wahrscheinlichkeit
  - Fundort: `pubspec.yaml:22-27`, `innenkompass/pubspec.yaml:22-28`, `lib/data/db/app_database.dart:293-297`
  - Auswirkung: Erhöhtes Build-/Runtime-Risiko auf Plattformen mit nativer SQLite-Bindung.

## Mittel
- [AUD-009] `AppRouter.goToIntervention()` verwendet einen inkompatiblen Payload-Key
  - Status: Bestätigt
  - Fundort: `lib/app/router.dart:289-299`, `lib/application/providers/app_providers.dart:70-75`
  - Auswirkung: Offizieller Routing-Helper ist unzuverlässig.

- [AUD-010] Interventionsschritte können veralteten lokalen Zustand anzeigen
  - Status: Bestätigt
  - Fundort: `lib/features/intervention/screens/intervention_screen.dart:125-138`, `lib/features/intervention/widgets/intervention_step_renderer.dart:32-39,295-304,374-378,517-520`
  - Auswirkung: Antworten können beim Vor-/Zurücknavigieren falsch dargestellt oder überschrieben werden.

- [AUD-011] Nachbewertung zeigt Defaults, hält Save aber deaktiviert
  - Status: Bestätigt
  - Fundort: `lib/features/intervention/screens/post_evaluation_screen.dart:26-45,242-245`
  - Auswirkung: Blockierende und widersprüchliche UX.

- [AUD-012] Hilfreichkeits-Skala ist inkonsistent
  - Status: Bestätigt
  - Fundort: `lib/features/intervention/screens/post_evaluation_screen.dart:180-185`, `lib/data/db/tables/situation_entries.dart:55-56`, `lib/features/history/screens/entry_detail_screen.dart:378-380`
  - Auswirkung: Gespeicherte Werte werden fachlich falsch interpretiert.

- [AUD-013] Diskret-/Normal-Notification-Toggle ist ohne Wirkung
  - Status: Bestätigt
  - Fundort: `lib/features/settings/widgets/notification_settings_section.dart:61-71`, `lib/domain/services/notification_service.dart:103-114,141-167`
  - Auswirkung: UI verspricht einen Modus, den der Service nicht kennt.

- [AUD-014] Lock-Service fängt Secure-Storage-Fehler nicht ab
  - Status: Hohe Wahrscheinlichkeit
  - Fundort: `lib/domain/services/lock_service.dart:55-123`
  - Auswirkung: Plattform- oder Pluginfehler können den Lock-Fluss instabil machen.

- [AUD-016] Migrationstest prüft nur Schema, nicht fachliche Datenkompatibilität
  - Status: Bestätigt
  - Fundort: `test/unit/database_migration_test.dart:93-145`, `lib/application/providers/new_situation_providers.dart:109-139`
  - Auswirkung: Potenzielle Bestandsdatenprobleme bleiben unentdeckt.

## Niedrig
- [AUD-015] Benutzerdefinierter Datumsfilter ist nicht implementiert
  - Status: Bestätigt
  - Fundort: `lib/domain/models/pattern_summary.dart:198-219`, `lib/features/history/widgets/history_filter_sheet.dart:134-150`
  - Auswirkung: Toter Filterpfad.

- [AUD-017] Privacy-/Support-Dokumente sind nicht release-fertig
  - Status: Bestätigt
  - Fundort: `docs/legal/privacy-policy-template.md:3,6-8,31`, `docs/legal/support-template.md:3,6-7`
  - Auswirkung: Dokumentations- und Release-Risiko.

- [AUD-018] Tote Settings-Artefakte verschleiern die aktive Architektur
  - Status: Bestätigt
  - Fundort: `lib/features/settings/widgets/notification_toggle.dart:12-13`, `lib/features/settings/widgets/emergency_contacts_section.dart:9-10`, `lib/application/providers/settings_provider.dart:21-38`
  - Auswirkung: Wartungsrauschen und höhere Drift-Gefahr.
