import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:innenkompass/data/dao/crisis_plan_dao.dart';
import 'package:innenkompass/data/dao/settings_dao.dart';
import 'package:innenkompass/data/db/app_database.dart';
import 'package:innenkompass/data/repositories/crisis_repository_impl.dart';
import 'package:innenkompass/domain/models/crisis_plan.dart';

void main() {
  test('moves legacy emergency contacts from settings into crisis plan',
      () async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);

    final settingsDao = SettingsDao(database);
    final repository = CrisisRepositoryImpl(
      crisisPlanDao: CrisisPlanDao(database),
      settingsDao: settingsDao,
    );

    await settingsDao.getOrCreate();
    await settingsDao.updateEmergencyContacts(const [
      EmergencyContact(
        name: 'Alex',
        phoneNumber: '+49 170 1234567',
        relationship: 'Freund/in',
      ),
    ]);

    final fullData = await repository.getFullCrisisData();
    final settingsAfterMigration = await settingsDao.getOrCreate();

    expect(fullData.emergencyContacts, hasLength(1));
    expect(fullData.emergencyContacts.first.name, 'Alex');
    expect(fullData.crisisPlan.emergencyContacts, hasLength(1));
    expect(settingsAfterMigration.emergencyContacts, isNull);
  });
}
