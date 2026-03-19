import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/db/app_database.dart';
import 'database_provider.dart';
import 'lock_provider.dart';
import 'notification_provider.dart';
import 'settings_provider.dart';

/// Snapshot of startup data needed to route the app after bootstrap.
class AppBootstrapSnapshot {
  const AppBootstrapSnapshot({
    required this.settings,
    required this.isLockEnabled,
    required this.lockType,
  });

  final UserSettingsData settings;
  final bool isLockEnabled;
  final String? lockType;
}

/// Initializes local app data once and hydrates the state notifiers.
final appBootstrapProvider = FutureProvider<AppBootstrapSnapshot>((ref) async {
  final db = ref.read(databaseProvider);

  var settings = await db.getOrCreateUserSettings();
  await db.getOrCreateCrisisPlan();

  final lockService = ref.read(lockServiceProvider);
  final isLockEnabled = await lockService.isLockEnabled();
  final lockType = await lockService.getLockType();

  if (settings.appLockEnabled != isLockEnabled ||
      settings.appLockType != lockType) {
    settings = settings.copyWith(
      appLockEnabled: isLockEnabled,
      appLockType: Value(lockType),
      updatedAt: DateTime.now(),
    );
    await db.updateUserSettings(settings);
  }

  final notificationService = ref.read(notificationServiceProvider);
  await notificationService.initialize();
  await syncNotificationSchedules(
    service: notificationService,
    settings: settings,
  );

  ref.read(settingsNotifierProvider.notifier).hydrate(settings);
  ref.read(lockStateProvider.notifier).hydrate(
        isEnabled: isLockEnabled,
        lockType: lockType,
      );

  return AppBootstrapSnapshot(
    settings: settings,
    isLockEnabled: isLockEnabled,
    lockType: lockType,
  );
});
