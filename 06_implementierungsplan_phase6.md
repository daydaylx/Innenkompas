# Phase 6: Krisenbereich + Einstellungen — Implementierungsplan

## Übersicht

Phase 6 umfasst 5 Kernbereiche:
1. **Krisenplan** — Vollständige Krisenplan-Verwaltung mit UI
2. **Kontakte** — Benutzerdefinierte Notfallkontakte (CRUD)
3. **Diskrete Notifications** — Lokale Benachrichtigungen mit Zeitkonfiguration
4. **App-Lock** — Optionale Biometrie/PIN-Sperre
5. **Daten löschen/exportieren** — Vollständige Datenverwaltung

## Abhängigkeiten-Graph

```
Batch 1 (Domain + Data Layer)
  ├── crisis_plan.dart (Model)
  ├── crisis_plan_dao.dart (DAO)
  ├── settings_dao.dart (DAO)
  ├── crisis_repository_impl.dart (Repository)
  └── notification_service.dart (Service)

Batch 2 (Application Layer)
  ├── crisis_controller.dart (Controller)
  └── lock_service.dart (Service)

Batch 3 (Presentation — Krisenbereich)
  ├── crisis_screen.dart
  ├── crisis_plan_edit_screen.dart
  ├── crisis_widgets (4 Dateien)
  └── Router-Update (/crisis/edit)

Batch 4 (Presentation — Einstellungen)
  ├── notification_settings_section.dart
  ├── app_lock_toggle.dart
  ├── lock_screen.dart
  ├── data_export_button.dart
  └── emergency_contacts_section.dart

Batch 5 (Integration + Pubspec)
  ├── app.dart (Lifecycle-Listener)
  ├── router.dart (Lock-Route + Guard)
  ├── pubspec.yaml (url_launcher)
  └── settings_screen.dart (Integration)
```

---

## Batch 1: Domain + Data Layer (Grundlagen)

Abhängigkeiten: Keine — startet direkt.

### 1.1 Domain Model: CrisisPlan

**Neue Datei:** `lib/domain/models/crisis_plan.dart`

```dart
@freezed
class CrisisPlan with _$CrisisPlan {
  const factory CrisisPlan({
    int? id,
    @Default([]) List<String> warningSigns,
    @Default([]) List<String> copingStrategies,
    @Default([]) List<EmergencyContact> socialSupport,
    String? safeEnvironment,
    @Default([]) List<ProfessionalResource> professionalResources,
    @Default([]) List<EmergencyContact> emergencyContacts,
    @Default([]) List<LocalResource> localResources,
    String? personalMotivation,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CrisisPlan;
}

@freezed
class EmergencyContact with _$EmergencyContact {
  const factory EmergencyContact({
    required String name,
    required String phoneNumber,
    String? relationship,
    String? note,
  }) = _EmergencyContact;
}

@freezed
class ProfessionalResource with _$ProfessionalResource {
  const factory ProfessionalResource({
    required String name,
    String? phoneNumber,
    String? address,
    String? website,
    String? type, // 'therapist', 'clinic', 'doctor'
  }) = _ProfessionalResource;
}

@freezed
class LocalResource with _$LocalResource {
  const factory LocalResource({
    required String name,
    String? description,
    String? phoneNumber,
    String? address,
  }) = _LocalResource;
```

**Enthält:** JSON-Mapper für DB-Serialisierung (fromJsonList/toJsonList für Listen-Felder)

---

### 1.2 DAO: CrisisPlanDao

**Neue Datei:** `lib/data/dao/crisis_plan_dao.dart`

```dart
class CrisisPlanDao {
  final AppDatabase _db;

  CrisisPlanDao(this._db);

  Future<CrisisPlan> getOrCreate();
  Future<CrisisPlan> update(CrisisPlan plan);
  Stream<CrisisPlan> watch();
  Future<void> clear();
}
```

**Enthält:** Mapping von DB-Row (`CrisisPlanData`) ↔ Domain-Model (`CrisisPlan`)

---

### 1.3 DAO: SettingsDao

**Neue Datei:** `lib/data/dao/settings_dao.dart`

```dart
class SettingsDao {
  final AppDatabase _db;

  SettingsDao(this._db);

  Future<UserSettingsData> getOrCreate();
  Future<void> updateNotificationsEnabled(bool enabled);
  Future<void> updateNotificationTimes(List<String> times);
  Future<void> updateDiscreteNotifications(bool enabled);
  Future<void> updateAppLock(bool enabled, String? type);
  Future<void> updateEmergencyContacts(List<EmergencyContact> contacts);
  Future<void> updateThemeMode(String mode);
  Future<void> updateLocale(String locale);
  Stream<UserSettingsData> watch();
  Future<void> clear();
}
```

---

### 1.4 Repository: CrisisRepositoryImpl

**Neue Datei:** `lib/data/repositories/crisis_repository_impl.dart`

```dart
class CrisisRepositoryImpl {
  final CrisisPlanDao _crisisPlanDao;
  final SettingsDao _settingsDao;

  // Crisis Plan
  Future<CrisisPlan> getCrisisPlan();
  Future<CrisisPlan> updateCrisisPlan(CrisisPlan plan);
  Stream<CrisisPlan> watchCrisisPlan();

  // Emergency Contacts (aus user_settings.emergencyContacts JSON)
  Future<List<EmergencyContact>> getEmergencyContacts();
  Future<void> updateEmergencyContacts(List<EmergencyContact> contacts);
  Future<void> addEmergencyContact(EmergencyContact contact);
  Future<void> removeEmergencyContact(String name);

  // Combined Crisis Data (Plan + Contacts für Screen)
  Future<CrisisData> getFullCrisisData();
}
```

**Enthält:** `CrisisData` Klasse die Plan + Contacts bündelt

---

### 1.5 Service: NotificationService

**Neue Datei:** `lib/domain/services/notification_service.dart`

```dart
class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin;

  Future<void> initialize();
  Future<void> requestPermissions();
  Future<void> scheduleDaily({
    required int id,
    required TimeOfDay time,
    required String title,
    required String body,
  });
  Future<void> scheduleMultiple(List<NotificationSchedule> schedules);
  Future<void> cancelAll();
  Future<void> cancel(int id);
  Future<bool> areNotificationsEnabled();
  List<String> getDiscreteNotificationMessages();
}
```

**Enthält:**
- `NotificationSchedule` Data-Klasse (id, time, type)
- Diskrete Nachrichten-Texte (keine sensiblen Inhalte):
  - "Zeit für eine kurze Einkehr 🌿"
  - "Wie fühlst du dich gerade?"
  - "Kurzer Check-In mit dir selbst"
  - "Ein Moment der Achtsamkeit"
  - "Dein Innenkompass erinnert dich"

---

### 1.6 Service: LockService

**Neue Datei:** `lib/domain/services/lock_service.dart`

```dart
class LockService {
  final LocalAuthentication _localAuth;
  final FlutterSecureStorage _secureStorage;

  Future<bool> isBiometricAvailable();
  Future<List<BiometricType>> getAvailableBiometrics();
  Future<bool> authenticate({String reason = 'App entsperren'});
  Future<void> setPin(String pin);
  Future<bool> verifyPin(String pin);
  Future<bool> hasPin();
  Future<void> deletePin();
  Future<bool> isLockEnabled();
  Future<void> setLockEnabled(bool enabled, {String? type});
}
```

---

## Batch 2: Application Layer (Controller + Provider)

Abhängigkeiten: Batch 1 muss fertig sein.

### 2.1 Controller: CrisisController

**Neue Datei:** `lib/application/controllers/crisis_controller.dart`

```dart
@freezed
class CrisisState with _$CrisisState {
  const factory CrisisState({
    CrisisPlan? crisisPlan,
    List<EmergencyContact> emergencyContacts,
    bool isLoading,
    String? error,
  }) = _CrisisState;
}

@riverpod
class CrisisController extends _$CrisisController {
  @override
  Future<CrisisState> build() async { ... }

  Future<void> updateWarningSigns(List<String> signs);
  Future<void> updateCopingStrategies(List<String> strategies);
  Future<void> updateSocialSupport(List<EmergencyContact> contacts);
  Future<void> updateSafeEnvironment(String notes);
  Future<void> updateProfessionalResources(List<ProfessionalResource> resources);
  Future<void> updatePersonalMotivation(String motivation);
  Future<void> updateEmergencyContacts(List<EmergencyContact> contacts);
  Future<void> addEmergencyContact(EmergencyContact contact);
  Future<void> removeEmergencyContact(String name);
  Future<void> loadCrisisPlan();
}
```

---

### 2.2 Provider: NotificationProvider

**Neue Datei:** `lib/application/providers/notification_provider.dart`

```dart
final notificationServiceProvider = Provider<NotificationService>((ref) { ... });

final notificationSettingsProvider = StateNotifierProvider<NotificationSettingsNotifier, NotificationSettings>((ref) { ... });

class NotificationSettingsNotifier extends StateNotifier<NotificationSettings> {
  Future<void> toggleEnabled(bool enabled);
  Future<void> updateTimes(List<TimeOfDay> times);
  Future<void> toggleDiscrete(bool discrete);
  Future<void> scheduleReminders();
}

@freezed
class NotificationSettings with _$NotificationSettings {
  const factory NotificationSettings({
    @Default(false) bool enabled,
    @Default(true) bool discrete,
    @Default([]) List<TimeOfDay> times,
  }) = _NotificationSettings;
}
```

---

### 2.3 Provider: LockProvider

**Neue Datei:** `lib/application/providers/lock_provider.dart`

```dart
final lockServiceProvider = Provider<LockService>((ref) { ... });

final lockStateProvider = StateNotifierProvider<LockStateNotifier, LockState>((ref) { ... });

@freezed
class LockState with _$LockState {
  const factory LockState({
    @Default(false) bool isEnabled,
    @Default(false) bool isLocked,
    String? lockType, // 'biometric', 'pin', 'biometric_and_pin'
  }) = _LockState;
}

class LockStateNotifier extends StateNotifier<LockState> {
  Future<void> initialize();
  Future<void> enableLock(String type);
  Future<void> disableLock();
  Future<bool> authenticate();
  void lock();
  void unlock();
}
```

---

## Batch 3: Presentation — Krisenbereich

Abhängigkeiten: Batch 1 + 2.

### 3.1 CrisisScreen

**Neue Datei:** `lib/features/crisis/screens/crisis_screen.dart`

**Inhalt:**
- Sofort-Verfügbar (immer erreichbar, auch ohne Login/Onboarding)
- **Header-Bereich:** Beruhigende Nachricht ("Du bist nicht allein")
- **Notfallkontakte-Sektion:**
  - Tap-to-call für alle Kontakte
  - Deutliche Telefon-Icons
- **Krisenplan-Vorschau:**
  - Warnzeichen (Top 3)
  - Sofortige Bewältigungsstrategien (Top 3)
  - Sicherer Ort
- **Schnellaktionen:**
  - Atemübung starten → direkte Regulation
  - Erdungsübung starten
  - Telefonseelsorge anrufen (0800 111 0 111)
- **Bearbeiten-Button** → navigiert zu `/crisis/edit`

---

### 3.2 CrisisPlanEditScreen

**Neue Datei:** `lib/features/crisis/screens/crisis_plan_edit_screen.dart`

**Inhalt:** Formular-basierte Bearbeitung aller Krisenplan-Felder:
- Warnzeichen (Chip-Input mit Hinzufügen/Entfernen)
- Bewältigungsstrategien (Liste mit Drag-to-Reorder)
- Soziale Unterstützung (Kontakt-Karten mit Bearbeiten)
- Sicherer Ort (Textfeld)
- Professionelle Ressourcen (Karten mit Name/Telefon/Typ)
- Persönliche Motivation (Mehrzeiliges Textfeld)
- Lokale Ressourcen (Karten)

---

### 3.3 Crisis Widgets

**Neue Dateien in `lib/features/crisis/widgets/`:**

1. **`emergency_contact_card.dart`**
   - Karte für einen Notfallkontakt
   - Name, Beziehung, Telefonnummer
   - Tap-to-call Button
   - Bearbeiten/Löschen im Edit-Mode

2. **`crisis_quick_action.dart`**
   - Wiederverwendbare Quick-Action-Karte
   - Icon, Titel, Beschreibung
   - Farbcodierung nach Dringlichkeit

3. **`crisis_plan_section.dart`**
   - Sektions-Widget für Krisenplan-Felder
   - Titel, Icon, bearbeitbare/inhaltsanzeige
   - Expand/Collapse

4. **`chip_input_field.dart`**
   - Chip-basierte Eingabe für Listen (Warnzeichen, Strategien)
   - Hinzufügen per Textfeld + Enter
   - Entfernen per Tap auf X

5. **`resource_card.dart`**
   - Karte für professionelle/lokale Ressourcen
   - Name, Typ, Kontakt-Infos
   - Call/Website Aktionen

---

### 3.4 Router-Update

**Datei:** `lib/app/router.dart` (Modifikation)

Neue Routen hinzufügen:
```dart
static const String crisisEdit = '/crisis/edit';
```

Im Router-Setup:
```dart
GoRoute(
  path: AppRoutes.crisisEdit,
  pageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: const CrisisPlanEditScreen(),
  ),
),
```

---

## Batch 4: Presentation — Einstellungen (erweitert)

Abhängigkeiten: Batch 1 + 2.

### 4.1 Notification Settings Section

**Neue Datei:** `lib/features/settings/widgets/notification_settings_section.dart`

**Inhalt:**
- Toggle: Benachrichtigungen aktivieren/deaktivieren
- Zeitkonfiguration: 1-3 Benachrichtigungszeiten (TimePicker)
- Toggle: Diskrete Benachrichtigungen (sensible Texte vermeiden)
- Vorschau: Beispiel-Nachricht anzeigen

---

### 4.2 AppLock Toggle Widget

**Neue Datei:** `lib/features/settings/widgets/app_lock_toggle.dart`

**Inhalt:**
- Toggle: App-Lock aktivieren/deaktivieren
- Bei Aktivierung: Auswahldialog (Biometrie / PIN / Beides)
- Bei Biometrie: Verfügbarkeit prüfen, Fallback auf PIN
- Status-Anzeige: Aktueller Lock-Modus
- PIN-Ändern Button (nur bei PIN aktiv)

---

### 4.3 Lock Screen

**Neue Datei:** `lib/features/lock/screens/lock_screen.dart`

**Inhalt:**
- Vollbild-Sperrbildschirm
- Bei Biometrie: automatisch Auth-Prompt öffnen
- Bei PIN: PIN-Eingabefeld (4-6 Ziffern)
- Fallback: Wenn Biometrie fehlschlägt → PIN-Eingabe
- Titel: "Innenkompass entsperren"
- Nach 3 Fehlversuchen: Wartezeit (30 Sekunden)
- Bei erfolgreichem Unlock: zur vorherigen Route zurück

---

### 4.4 Data Export Button

**Neue Datei:** `lib/features/settings/widgets/data_export_button.dart`

**Inhalt:**
- Button: "Daten exportieren"
- Exportiert als JSON (nutzt `AppDatabase.exportToJson()`)
- Share-Sheet anzeigen (share_plus oder system share)
- Alternative: In Datei speichern mit path_provider
- Hinweis: "Deine Daten bleiben auf diesem Gerät"

---

### 4.5 Emergency Contacts Section (Settings)

**Neue Datei:** `lib/features/settings/widgets/emergency_contacts_section.dart`

**Inhalt:** (Ersetzt die bestehende hardcoded Sektion in settings_screen.dart)
- Liste aller benutzerdefinierten Kontakte
- "Hinzufügen" Button → öffnet Kontakt-Formular
- Bearbeiten/Löschen pro Kontakt
- Kontakt-Formular: Name, Telefonnummer, Beziehung (Dropdown), Notiz
- Reorderable Liste (Drag & Drop)

**Neue Datei:** `lib/features/settings/screens/emergency_contact_form.dart`
- Formular für neuen/bearbeiteten Kontakt
- Validierung: Name und Telefonnummer erforderlich
- Beziehung-Dropdown (Partner, Eltern, Freund, Therapeut, etc.)

---

### 4.6 Settings Screen Update

**Modifizierte Datei:** `lib/features/settings/screens/settings_screen.dart`

Änderungen:
- Ersetze hardcoded EmergencyContacts durch `EmergencyContactsSection`
- Füge `NotificationSettingsSection` hinzu (unter NotificationToggle)
- Füge `AppLockToggle` hinzu (neue Sektion "Sicherheit")
- Füge `DataExportButton` hinzu (unter DataCleanupButton)
- Entferne veraltete TODO-Kommentare

---

## Batch 5: Integration + Pubspec

Abhängigkeiten: Alle vorherigen Batches.

### 5.1 pubspec.yaml Update

**Modifizierte Datei:** `pubspec.yaml`

Neue Dependencies hinzufügen:
```yaml
dependencies:
  url_launcher: ^6.2.5  # Für Telefonanrufe von Notfallkontakten
  share_plus: ^10.0.0   # Für Datenexport (Share-Sheet)
```

---

### 5.2 App Lifecycle Integration

**Modifizierte Datei:** `lib/app/app.dart` (oder wo MaterialApp erstellt wird)

Änderungen:
- `WidgetsBindingObserver` mixin hinzufügen
- Bei `AppLifecycleState.paused` → App locken (wenn Lock aktiv)
- Bei `AppLifecycleState.resumed` → Lock-Screen anzeigen (wenn locked)
- `NavigatorObserver` für Route-Guards

---

### 5.3 Router Lock Guard

**Modifizierte Datei:** `lib/app/router.dart`

Änderungen:
- Redirect-Logik: Wenn App locked und nicht auf `/lock` → redirect zu `/lock`
- `/lock` Route hinzufügen (ohne Auth-Check)
- Crisis-Routen: Auch ohne Onboarding erreichbar (safety-critical)

```dart
// Redirect Logic Update:
if (lockState.isLocked && state.matchedLocation != '/lock') {
  return '/lock';
}
```

---

### 5.4 Crisis Hotline Integration

**Modifizierte Datei:** `lib/features/settings/widgets/emergency_contact_item.dart`

Änderungen:
- `url_launcher` importieren
- `onTap` → `launchUrl(Uri.parse('tel:$phoneNumber'))` statt SnackBar
- Fehlerbehandlung für fehlende Telefon-App

---

### 5.5 Database Provider Update

**Modifizierte Datei:** `lib/application/providers/database_provider.dart`

Änderungen:
- DAO-Provider hinzufügen:
```dart
final crisisPlanDaoProvider = Provider<CrisisPlanDao>((ref) {
  return CrisisPlanDao(ref.watch(databaseProvider));
});

final settingsDaoProvider = Provider<SettingsDao>((ref) {
  return SettingsDao(ref.watch(databaseProvider));
});
```

---

## Zusammenfassung: Neue Dateien

| # | Dateipfad | Typ | Beschreibung |
|---|-----------|-----|--------------|
| 1 | `lib/domain/models/crisis_plan.dart` | Model | CrisisPlan + EmergencyContact + ProfessionalResource + LocalResource (freezed) |
| 2 | `lib/data/dao/crisis_plan_dao.dart` | DAO | CRUD für crisis_plan Tabelle |
| 3 | `lib/data/dao/settings_dao.dart` | DAO | CRUD für user_settings Tabelle |
| 4 | `lib/data/repositories/crisis_repository_impl.dart` | Repository | Zusammenführung CrisisPlan + EmergencyContacts |
| 5 | `lib/domain/services/notification_service.dart` | Service | flutter_local_notifications Wrapper |
| 6 | `lib/domain/services/lock_service.dart` | Service | local_auth + secure_storage Wrapper |
| 7 | `lib/application/controllers/crisis_controller.dart` | Controller | StateNotifier/Provider für Krisenbereich |
| 8 | `lib/application/providers/notification_provider.dart` | Provider | NotificationSettings State |
| 9 | `lib/application/providers/lock_provider.dart` | Provider | LockState State |
| 10 | `lib/features/crisis/screens/crisis_screen.dart` | Screen | Haupt-Krisenscreen |
| 11 | `lib/features/crisis/screens/crisis_plan_edit_screen.dart` | Screen | Krisenplan bearbeiten |
| 12 | `lib/features/crisis/widgets/emergency_contact_card.dart` | Widget | Notfallkontakt-Karte |
| 13 | `lib/features/crisis/widgets/crisis_quick_action.dart` | Widget | Quick-Action-Karte |
| 14 | `lib/features/crisis/widgets/crisis_plan_section.dart` | Widget | Krisenplan-Sektion |
| 15 | `lib/features/crisis/widgets/chip_input_field.dart` | Widget | Chip-Listen-Eingabe |
| 16 | `lib/features/crisis/widgets/resource_card.dart` | Widget | Ressourcen-Karte |
| 17 | `lib/features/settings/widgets/notification_settings_section.dart` | Widget | Notification-Zeitkonfiguration |
| 18 | `lib/features/settings/widgets/app_lock_toggle.dart` | Widget | App-Lock Einstellung |
| 19 | `lib/features/lock/screens/lock_screen.dart` | Screen | Sperrbildschirm |
| 20 | `lib/features/settings/widgets/data_export_button.dart` | Widget | Datenexport-Button |
| 21 | `lib/features/settings/widgets/emergency_contacts_section.dart` | Widget | Kontakte-Verwaltung |
| 22 | `lib/features/settings/screens/emergency_contact_form.dart` | Screen | Kontakt-Formular |

## Zusammenfassung: Modifizierte Dateien

| # | Dateipfad | Änderung |
|---|-----------|----------|
| 1 | `pubspec.yaml` | `url_launcher`, `share_plus` hinzufügen |
| 2 | `lib/app/router.dart` | `/crisis/edit` + `/lock` Routen, Lock-Redirect |
| 3 | `lib/app/app.dart` | WidgetsBindingObserver für Lifecycle |
| 4 | `lib/features/settings/screens/settings_screen.dart` | Neue Widgets integrieren |
| 5 | `lib/features/settings/widgets/emergency_contact_item.dart` | url_launcher für Anrufe |
| 6 | `lib/application/providers/database_provider.dart` | DAO-Provider hinzufügen |
| 7 | `lib/features/settings/widgets/data_cleanup_button.dart` | Vollständige Datenlöschung (clearAllData) |

---

## Implementierungsreihenfolge (empfohlen)

```
Schritt 1: Batch 1 (Domain + Data)         → ~4 Dateien
Schritt 2: Batch 2 (Application)           → ~3 Dateien
Schritt 3: Batch 3 (Krisenbereich UI)      → ~8 Dateien + Router-Update
Schritt 4: Batch 4 (Einstellungen UI)      → ~6 Dateien
Schritt 5: Batch 5 (Integration)           → ~5 Modifikationen
Schritt 6: pubspec + build_runner          → Code-Generierung
Schritt 7: Testing + Bugfixes
```

**Geschätzter Gesamtumfang:** 22 neue Dateien + 7 Modifizierte Dateien

---

## Technische Hinweise

### JSON-Serialisierung für DB-Felder
- `warningSigns`, `copingStrategies`, `socialSupport`, `professionalResources`, `emergencyContacts`, `localResources` sind JSON-Textfelder in der DB
- Mapping: `jsonEncode(list)` beim Schreiben, `jsonDecode(string)` beim Lesen
- CrisisPlan Model enthält `toJsonMap()` / `fromJsonMap()` Methoden

### Diskrete Notifications
- Keine sensiblen Inhalte in Notification-Texten
- Konfigurierbare Zeiten (1-3 pro Tag)
- Standard: 1x täglich um 18:00
- Diskret-Modus: generische Texte ("Zeit für eine kurze Einkehr")

### App-Lock Flow
1. User aktiviert Lock in Settings
2. Biometrie-Check → verfügbar? Wenn ja: Biometrie + optional PIN
3. Wenn nicht: Nur PIN (4-6 Ziffern)
4. PIN wird in flutter_secure_storage gespeichert (verschlüsselt)
5. Bei App-Resume: Lock-State prüfen → Lock-Screen anzeigen

### Krisenplan als Safety-Critical Feature
- CrisisScreen ist IMMER erreichbar (auch ohne Onboarding, auch bei Lock)
- Router-Override: Crisis-Routen von Lock/Onboarding-Redirect ausnehmen
- Schnellzugriff: Floating-Button auf HomeScreen + Route `/crisis`
