# REMEDIATION PLAN

## Zielbild
- Ein einziges Root-Repo ohne sicherheitsrelevante Drift zur Referenzkopie.
- Deterministischer App-Start mit sauberem Bootstrap für DB, Settings, Lock und Notifications.
- Eine einzige Wahrheitsquelle pro fachlichem Zustand.
- Reproduzierbare Builds und belastbare Regressionstests für kritische Flüsse.

## Phase 0: Arbeitsgrundlage absichern
- Referenzkopie `innenkompass/` systematisch gegen das Root-Repo diffen und sicherheits-/bootstraprelevante Änderungen identifizieren.
- Dirty Worktree vor den eigentlichen Fixes sauber einordnen:
  - `lib/features/intervention/screens/intervention_screen.dart`
  - `test/features/`
- Lokale Toolchain herstellen:
  - `flutter --version`
  - `dart --version`
  - `flutter pub get`
  - `dart run build_runner build --delete-conflicting-outputs`

## Phase 1: Kritische Sicherheits- und Vertrauensbrüche beheben
### 1. Lock-Bootstrap zentralisieren
- Einen dedizierten Bootstrap-Provider einführen, der vor Routing vollständig lädt:
  - Datenbank-Setup
  - User-Settings
  - Lock-Status und Lock-Typ
  - optional Notification-Service-Initialisierung
- `routerProvider` reaktiv an den Lock-State anbinden; keine `ref.read(...)`-Abfrage für Routing-Entscheidungen.
- `SplashScreen` erst routen lassen, wenn Lock-Hydrierung beendet ist.
- App-Lifecycle-Resume explizit gegen Lock-Redirect testen.

### 2. Echte Datenlöschung umsetzen
- `DataCleanupButton` auf echte Bereinigung umstellen:
  - `AppDatabase.clearAllData()`
  - Secure-Storage-Lockdaten löschen
  - Riverpod-Notifiers resetten
  - danach deterministisch zum Onboarding routen
- Dialogtexte nur beibehalten, wenn das Verhalten exakt dazu passt.

### 3. Settings-Schreibpfad entkoppeln von `id == 1`
- Single-Row-Settings-Strategie implementieren:
  - vorhandene Settings-Zeile laden
  - Änderungen auf reale ID anwenden oder per `replace()` auf dem geladenen Datensatz schreiben
- Regressionstest:
  - `user_settings` leeren
  - neu erzeugen
  - Locale/Notifications/Lock ändern
  - Persistenz prüfen

## Phase 2: Fachlogik und UX korrigieren
### 4. Notification-Subsystem konsolidieren
- `notification_provider.dart` an persistente Settings anbinden oder komplett in `settings_provider.dart` integrieren.
- `NotificationService.initialize()` einmalig im Bootstrap ausführen.
- Diskret-/Normal-Modus technisch entscheiden:
  - entweder echte alternative Texte implementieren
  - oder Toggle entfernen
- Reminder-Zeiten und Flags in der DB lesen und schreiben.

### 5. Krisenpfad logisch schließen
- `ClassificationService.classify()` so ändern, dass erkannte Krisen im Selektor ankommen:
  - `SystemState.crisis` setzen oder
  - explizites `isCrisis`/`crisisSeverity` an den Selektor übergeben
- Regressionstests für hohe Intensität und krisenhafte Gedanken ergänzen.

### 6. Zeitsemantik vereinheitlichen
- Fachliche Primärzeit definieren:
  - `timestamp` für Anzeige, Sortierung, Verlauf, Filter, Trendanalyse
  - `createdAt` nur noch als technische Persistenzmetadaten
- Alle betroffenen Lesepfade anpassen:
  - `PatternAnalyzer`
  - `filteredHistoryEntries`
  - `last7DaysTrend`
  - Home-Preview
  - History-Card
  - Entry-Detail
- Regressionstest für rückdatierte Einträge anlegen.

### 7. Interventions-Flow stabilisieren
- `InterventionStepRenderer` mit `ValueKey(step.id)` instanziieren.
- Stateful Step-Widgets auf `didUpdateWidget()` oder zustandslose Ableitung aus Provider-State umstellen.
- Nachbewertung im `initState()` mit Defaultwerten in den Provider initialisieren.
- Hilfreichkeits-Skala auf eine Definition normieren und ggf. Datenmigration ergänzen.

## Phase 3: Repo-Hygiene, Tests und Build-Härtung
### 8. Drift zwischen Root und Referenzkopie abbauen
- Sicherheitsrelevante Fixes aus `innenkompass/` gezielt portieren:
  - `bootstrap_provider.dart`
  - gehärteter `lock_service.dart`
  - Post-Evaluation-Fix
- Danach Referenzkopie nicht weiter als impliziten Patch-Container nutzen.

### 9. Tote Pfade entfernen
- Entfernen oder sauber reintegrieren:
  - `NotificationToggle`
  - `EmergencyContactsSection`
  - ungenutzte Settings-Provider
  - `DateRangeFilter.benutzerdefiniert`, falls nicht kurzfristig implementiert

### 10. CI reproduzierbar machen
- Flutter-Version in `.github/workflows/ci.yml` pinnen statt nur `stable`.
- Unit- und Widget-Tests beibehalten.
- `integration_test/app_smoke_test.dart` in die Pipeline aufnehmen.
- Optional:
  - Caching für Pub/Flutter
  - separates Job-Splitting für Analyze/Test/Integration

### 11. Release-Dokumente fertigstellen
- `docs/legal/privacy-policy-template.md` vervollständigen
- `docs/legal/support-template.md` vervollständigen
- `docs/release/go-live-checklist.md` um harte Gates für:
  - rechtliche Angaben
  - Lock-Verifikation
  - Cleanup-Verifikation
  - Notification-Verifikation

## Mindest-Testplan nach Sanierung
- `flutter analyze`
- `flutter test`
- `flutter test integration_test`
- manueller Smoke-Test:
  - App-Lock aktivieren, App killen, neu starten
  - App in Hintergrund/Vordergrund schicken
  - Notification-Einstellungen ändern, App neu starten
  - Daten exportieren
  - Daten löschen und DB/Lock zurückgesetzt prüfen
  - rückdatierten Eintrag erfassen und Verlauf/Pattern prüfen

## Reihenfolge mit höchstem Hebel
- 1. Lock-Bootstrap
- 2. echte Datenlöschung
- 3. robuste Settings-Persistenz
- 4. Notification-Konsolidierung
- 5. Kriseneskalation
- 6. Zeitsemantik
- 7. Interventions-UI-State
- 8. CI/Tests/Docs
