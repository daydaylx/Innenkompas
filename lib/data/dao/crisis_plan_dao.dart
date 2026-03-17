import 'package:drift/drift.dart';
import '../../data/db/app_database.dart';
import '../../domain/models/crisis_plan.dart';

/// DAO for crisis plan data access.
///
/// Wraps AppDatabase methods and handles mapping between
/// Drift data classes and domain models.
class CrisisPlanDao {
  CrisisPlanDao(this._db);

  final AppDatabase _db;

  /// Get crisis plan or create an empty one.
  Future<CrisisPlan> getOrCreate() async {
    final data = await _db.getOrCreateCrisisPlan();
    return _mapToDomain(data);
  }

  /// Get crisis plan if it exists.
  Future<CrisisPlan?> get() async {
    final data = await _db.getCrisisPlan();
    if (data == null) return null;
    return _mapToDomain(data);
  }

  /// Update the crisis plan.
  Future<CrisisPlan> update(CrisisPlan plan) async {
    final existing = await _db.getCrisisPlan();
    if (existing == null) {
      // Create new
      await _db.createCrisisPlan(CrisisPlanCompanion.insert(
        warningSigns: Value(_encodeStringList(plan.warningSigns)),
        copingStrategies: Value(_encodeStringList(plan.copingStrategies)),
        socialSupport: Value(EmergencyContact.listToJson(plan.socialSupport)),
        safeEnvironment: Value(plan.safeEnvironment),
        professionalResources:
            Value(ProfessionalResource.listToJson(plan.professionalResources)),
        emergencyContacts:
            Value(EmergencyContact.listToJson(plan.emergencyContacts)),
        localResources: Value(LocalResource.listToJson(plan.localResources)),
        personalMotivation: Value(plan.personalMotivation),
      ));
    } else {
      // Update existing using copyWithCompanion
      final companion = CrisisPlanCompanion(
        warningSigns: Value(_encodeStringList(plan.warningSigns)),
        copingStrategies: Value(_encodeStringList(plan.copingStrategies)),
        socialSupport: Value(EmergencyContact.listToJson(plan.socialSupport)),
        safeEnvironment: Value(plan.safeEnvironment),
        professionalResources:
            Value(ProfessionalResource.listToJson(plan.professionalResources)),
        emergencyContacts:
            Value(EmergencyContact.listToJson(plan.emergencyContacts)),
        localResources: Value(LocalResource.listToJson(plan.localResources)),
        personalMotivation: Value(plan.personalMotivation),
        updatedAt: Value(DateTime.now()),
      );
      await _db.updateCrisisPlan(existing.copyWithCompanion(companion));
    }

    return getOrCreate();
  }

  /// Map Drift data to domain model.
  CrisisPlan _mapToDomain(CrisisPlanData data) {
    return CrisisPlan(
      id: data.id,
      warningSigns: _decodeStringList(data.warningSigns),
      copingStrategies: _decodeStringList(data.copingStrategies),
      socialSupport: EmergencyContact.listFromJson(data.socialSupport),
      safeEnvironment: data.safeEnvironment,
      professionalResources:
          ProfessionalResource.listFromJson(data.professionalResources),
      emergencyContacts: EmergencyContact.listFromJson(data.emergencyContacts),
      localResources: LocalResource.listFromJson(data.localResources),
      personalMotivation: data.personalMotivation,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }

  /// Encode a list of strings as delimiter-separated string.
  String? _encodeStringList(List<String> list) {
    if (list.isEmpty) return null;
    return list.join('|||');
  }

  /// Decode a delimiter-separated string to list of strings.
  List<String> _decodeStringList(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) return [];
    return jsonString.split('|||');
  }
}
