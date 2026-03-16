import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/db/app_database.dart';
import 'database_provider.dart';

/// Provider for secure storage instance.
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );
});

/// Provider for onboarding completion status.
///
/// This checks if the user has completed the onboarding flow.
final onboardingCompletedProvider = FutureProvider<bool>((ref) async {
  final db = ref.watch(databaseProvider);
  final settings = await db.getUserSettings();
  return settings?.onboardingCompleted ?? false;
});

/// Provider for current onboarding status (synchronous version for router)
final onboardingCompletedSyncProvider = Provider<bool>((ref) {
  // Default to false, will be updated by the async provider
  // This is used by the router which needs synchronous access
  return false;
});

/// Provider for reading user settings from database.
final settingsProvider = FutureProvider<UserSettingsData>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getOrCreateUserSettings();
});

/// Provider for settings state.
///
/// This will be used to manage app-wide settings.
class SettingsNotifier extends StateNotifier<UserSettingsData?> {
  SettingsNotifier(this.ref) : super(null) {
    _loadSettings();
  }

  final Ref ref;

  Future<void> _loadSettings() async {
    final db = ref.read(databaseProvider);
    state = await db.getOrCreateUserSettings();
  }

  Future<void> updateLocale(String locale) async {
    if (state == null) return;
    final db = ref.read(databaseProvider);
    final updated = state!.copyWith(locale: locale);
    await db.updateUserSettings(updated);
    state = updated;
  }

  Future<void> toggleNotifications(bool enabled) async {
    if (state == null) return;
    final db = ref.read(databaseProvider);
    final updated = state!.copyWith(notificationsEnabled: enabled);
    await db.updateUserSettings(updated);
    state = updated;
  }

  Future<void> toggleAppLock(bool enabled) async {
    if (state == null) return;
    final db = ref.read(databaseProvider);
    final updated = state!.copyWith(appLockEnabled: enabled);
    await db.updateUserSettings(updated);
    state = updated;
  }

  Future<void> updateThemeMode(String themeMode) async {
    if (state == null) return;
    final db = ref.read(databaseProvider);
    final updated = state!.copyWith(themeMode: themeMode);
    await db.updateUserSettings(updated);
    state = updated;
  }
}

/// Settings state notifier provider.
final settingsNotifierProvider =
    StateNotifierProvider<SettingsNotifier, UserSettingsData?>((ref) {
  return SettingsNotifier(ref);
});

/// UserSettingsData extension for copyWith.
extension UserSettingsDataCopyWith on UserSettingsData {
  UserSettingsData copyWith({
    String? locale,
    bool? notificationsEnabled,
    bool? appLockEnabled,
    String? themeMode,
    DateTime? lastBackupAt,
  }) {
    return UserSettingsData(
      id: id,
      onboardingCompleted: onboardingCompleted,
      isFirstLaunch: isFirstLaunch,
      locale: locale ?? this.locale,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      notificationTimes: notificationTimes,
      discreteNotifications: discreteNotifications,
      appLockEnabled: appLockEnabled ?? this.appLockEnabled,
      appLockType: appLockType,
      themeMode: themeMode ?? this.themeMode,
      emergencyContacts: emergencyContacts,
      analyticsEnabled: analyticsEnabled,
      lastBackupAt: lastBackupAt ?? this.lastBackupAt,
      lastDataCleanupAt: lastDataCleanupAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
