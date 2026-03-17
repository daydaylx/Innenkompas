import '../../domain/models/crisis_plan.dart';
import '../dao/crisis_plan_dao.dart';
import '../dao/settings_dao.dart';

/// Repository that aggregates crisis plan and emergency contacts.
class CrisisRepositoryImpl {
  CrisisRepositoryImpl({
    required CrisisPlanDao crisisPlanDao,
    required SettingsDao settingsDao,
  })  : _crisisPlanDao = crisisPlanDao,
        _settingsDao = settingsDao;

  final CrisisPlanDao _crisisPlanDao;
  final SettingsDao _settingsDao;

  /// Get the full crisis data (plan + contacts).
  Future<CrisisData> getFullCrisisData() async {
    var plan = await _crisisPlanDao.getOrCreate();
    final settings = await _settingsDao.getOrCreate();
    final legacyContacts = _parseEmergencyContacts(settings.emergencyContacts);

    if (plan.emergencyContacts.isEmpty && legacyContacts.isNotEmpty) {
      plan = await _crisisPlanDao.update(
        plan.copyWith(emergencyContacts: legacyContacts),
      );
      await _settingsDao.updateEmergencyContacts(const []);
    }

    return CrisisData(
      crisisPlan: plan,
      emergencyContacts: plan.emergencyContacts,
    );
  }

  /// Get crisis plan.
  Future<CrisisPlan> getCrisisPlan() async {
    return _crisisPlanDao.getOrCreate();
  }

  /// Update crisis plan.
  Future<CrisisPlan> updateCrisisPlan(CrisisPlan plan) async {
    final updated = await _crisisPlanDao.update(plan);
    await _settingsDao.updateEmergencyContacts(const []);
    return updated;
  }

  /// Get emergency contacts from settings.
  Future<List<EmergencyContact>> getEmergencyContacts() async {
    final plan = await getCrisisPlan();
    return plan.emergencyContacts;
  }

  /// Update emergency contacts in the crisis plan.
  Future<void> updateEmergencyContacts(List<EmergencyContact> contacts) async {
    final plan = await getCrisisPlan();
    await updateCrisisPlan(plan.copyWith(emergencyContacts: contacts));
  }

  /// Add a single emergency contact.
  Future<void> addEmergencyContact(EmergencyContact contact) async {
    final contacts = await getEmergencyContacts();
    contacts.add(contact);
    await updateEmergencyContacts(contacts);
  }

  /// Remove an emergency contact by name.
  Future<void> removeEmergencyContact(String name) async {
    final contacts = await getEmergencyContacts();
    contacts.removeWhere((c) => c.name == name);
    await updateEmergencyContacts(contacts);
  }

  /// Update a specific field of the crisis plan.
  Future<void> updateWarningSigns(List<String> signs) async {
    final plan = await getCrisisPlan();
    await updateCrisisPlan(plan.copyWith(warningSigns: signs));
  }

  Future<void> updateCopingStrategies(List<String> strategies) async {
    final plan = await getCrisisPlan();
    await updateCrisisPlan(plan.copyWith(copingStrategies: strategies));
  }

  Future<void> updateSafeEnvironment(String? notes) async {
    final plan = await getCrisisPlan();
    await updateCrisisPlan(plan.copyWith(safeEnvironment: notes));
  }

  Future<void> updatePersonalMotivation(String? motivation) async {
    final plan = await getCrisisPlan();
    await updateCrisisPlan(plan.copyWith(personalMotivation: motivation));
  }

  List<EmergencyContact> _parseEmergencyContacts(String? jsonString) {
    return EmergencyContact.listFromJson(jsonString);
  }
}

/// Bundled crisis data for the crisis screen.
class CrisisData {
  const CrisisData({
    required this.crisisPlan,
    required this.emergencyContacts,
  });

  final CrisisPlan crisisPlan;
  final List<EmergencyContact> emergencyContacts;
}
