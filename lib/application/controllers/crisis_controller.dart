import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/crisis_plan.dart';
import '../../data/repositories/crisis_repository_impl.dart';
import '../providers/database_provider.dart';
import '../../data/dao/crisis_plan_dao.dart';
import '../../data/dao/settings_dao.dart';

/// State for the crisis controller.
class CrisisState {
  const CrisisState({
    this.crisisPlan,
    this.emergencyContacts = const [],
    this.isLoading = false,
    this.error,
  });

  final CrisisPlan? crisisPlan;
  final List<EmergencyContact> emergencyContacts;
  final bool isLoading;
  final String? error;

  CrisisState copyWith({
    CrisisPlan? crisisPlan,
    List<EmergencyContact>? emergencyContacts,
    bool? isLoading,
    String? error,
  }) {
    return CrisisState(
      crisisPlan: crisisPlan ?? this.crisisPlan,
      emergencyContacts: emergencyContacts ?? this.emergencyContacts,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Provider for crisis plan DAO.
final crisisPlanDaoProvider = Provider<CrisisPlanDao>((ref) {
  return CrisisPlanDao(ref.watch(databaseProvider));
});

/// Provider for settings DAO.
final settingsDaoProvider = Provider<SettingsDao>((ref) {
  return SettingsDao(ref.watch(databaseProvider));
});

/// Provider for crisis repository.
final crisisRepositoryProvider = Provider<CrisisRepositoryImpl>((ref) {
  return CrisisRepositoryImpl(
    crisisPlanDao: ref.watch(crisisPlanDaoProvider),
    settingsDao: ref.watch(settingsDaoProvider),
  );
});

/// Notifier for managing crisis state.
class CrisisController extends StateNotifier<CrisisState> {
  CrisisController(this._repository) : super(const CrisisState()) {
    loadData();
  }

  final CrisisRepositoryImpl _repository;

  /// Load crisis data from repository.
  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      final data = await _repository.getFullCrisisData();
      state = state.copyWith(
        crisisPlan: data.crisisPlan,
        emergencyContacts: data.emergencyContacts,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Update warning signs.
  Future<void> updateWarningSigns(List<String> signs) async {
    await _repository.updateWarningSigns(signs);
    await loadData();
  }

  /// Update coping strategies.
  Future<void> updateCopingStrategies(List<String> strategies) async {
    await _repository.updateCopingStrategies(strategies);
    await loadData();
  }

  /// Update safe environment notes.
  Future<void> updateSafeEnvironment(String? notes) async {
    await _repository.updateSafeEnvironment(notes);
    await loadData();
  }

  /// Update personal motivation.
  Future<void> updatePersonalMotivation(String? motivation) async {
    await _repository.updatePersonalMotivation(motivation);
    await loadData();
  }

  /// Update full crisis plan.
  Future<void> updateCrisisPlan(CrisisPlan plan) async {
    await _repository.updateCrisisPlan(plan);
    await loadData();
  }

  /// Add emergency contact.
  Future<void> addEmergencyContact(EmergencyContact contact) async {
    await _repository.addEmergencyContact(contact);
    await loadData();
  }

  /// Remove emergency contact.
  Future<void> removeEmergencyContact(String name) async {
    await _repository.removeEmergencyContact(name);
    await loadData();
  }

  /// Update all emergency contacts.
  Future<void> updateEmergencyContacts(List<EmergencyContact> contacts) async {
    await _repository.updateEmergencyContacts(contacts);
    await loadData();
  }

  /// Update all social support contacts.
  Future<void> updateSocialSupport(List<EmergencyContact> contacts) async {
    final plan = await _repository.getCrisisPlan();
    await _repository.updateCrisisPlan(plan.copyWith(socialSupport: contacts));
    await loadData();
  }

  /// Update all professional resources.
  Future<void> updateProfessionalResources(
      List<ProfessionalResource> resources) async {
    final plan = await _repository.getCrisisPlan();
    await _repository
        .updateCrisisPlan(plan.copyWith(professionalResources: resources));
    await loadData();
  }

  /// Update all local resources.
  Future<void> updateLocalResources(List<LocalResource> resources) async {
    final plan = await _repository.getCrisisPlan();
    await _repository
        .updateCrisisPlan(plan.copyWith(localResources: resources));
    await loadData();
  }
}

/// Provider for the crisis controller.
final crisisControllerProvider =
    StateNotifierProvider<CrisisController, CrisisState>((ref) {
  return CrisisController(ref.watch(crisisRepositoryProvider));
});
