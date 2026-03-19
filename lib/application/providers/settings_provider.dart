import 'package:drift/drift.dart';
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

/// Provider for reading user settings from database.
final settingsProvider = FutureProvider<UserSettingsData>((ref) async {
  final db = ref.watch(databaseProvider);
  return db.getOrCreateUserSettings();
});

/// Provider for settings state.
///
/// This will be used to manage app-wide settings.
class SettingsNotifier extends StateNotifier<UserSettingsData?> {
  SettingsNotifier(this.ref) : super(null);

  final Ref ref;

  void hydrate(UserSettingsData settings) {
    state = settings;
  }

  Future<UserSettingsData> _requireSettings() async {
    final current = state;
    if (current != null) {
      return current;
    }

    final db = ref.read(databaseProvider);
    final loaded = await db.getOrCreateUserSettings();
    state = loaded;
    return loaded;
  }

  Future<void> _persist(
    UserSettingsData Function(UserSettingsData current) buildUpdated,
  ) async {
    final db = ref.read(databaseProvider);
    final current = await _requireSettings();
    final updated = buildUpdated(current).copyWith(updatedAt: DateTime.now());
    await db.updateUserSettings(updated);
    state = updated;
  }

  Future<void> updateLocale(String locale) async {
    await _persist((current) => current.copyWith(locale: locale));
  }

  Future<void> toggleNotifications(bool enabled) async {
    await updateNotificationSettings(notificationsEnabled: enabled);
  }

  Future<void> toggleAppLock(bool enabled) async {
    await updateAppLockSettings(enabled);
  }

  Future<void> updateNotificationSettings({
    bool? notificationsEnabled,
    String? notificationTimes,
    bool clearNotificationTimes = false,
    bool? discreteNotifications,
  }) async {
    await _persist(
      (current) => current.copyWith(
        notificationsEnabled: notificationsEnabled,
        notificationTimes: clearNotificationTimes
            ? const Value(null)
            : notificationTimes != null
                ? Value(notificationTimes)
                : const Value.absent(),
        discreteNotifications: discreteNotifications,
      ),
    );
  }

  Future<void> updateAppLockSettings(
    bool enabled, {
    String? lockType,
    bool clearLockType = false,
  }) async {
    await _persist(
      (current) => current.copyWith(
        appLockEnabled: enabled,
        appLockType: clearLockType
            ? const Value(null)
            : lockType != null
                ? Value(lockType)
                : const Value.absent(),
      ),
    );
  }

  Future<void> updateThemeMode(String themeMode) async {
    await _persist((current) => current.copyWith(themeMode: themeMode));
  }

  Future<void> completeOnboarding() async {
    await _persist(
      (current) => current.copyWith(
        onboardingCompleted: true,
        isFirstLaunch: false,
      ),
    );
  }

  Future<void> resetOnboarding() async {
    await _persist(
      (current) => current.copyWith(
        onboardingCompleted: false,
        isFirstLaunch: true,
      ),
    );
  }
}

/// Settings state notifier provider.
final settingsNotifierProvider =
    StateNotifierProvider<SettingsNotifier, UserSettingsData?>((ref) {
  return SettingsNotifier(ref);
});
