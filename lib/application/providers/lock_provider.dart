import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import '../../domain/services/lock_service.dart';
import 'settings_provider.dart';

const _lockTypeUnset = Object();

/// Provider for LocalAuthentication instance.
final localAuthProvider = Provider<LocalAuthentication>((ref) {
  return LocalAuthentication();
});

/// Provider for the lock service.
final lockServiceProvider = Provider<LockService>((ref) {
  return LockService(
    localAuth: ref.watch(localAuthProvider),
    secureStorage: ref.watch(secureStorageProvider),
  );
});

/// Lock state.
class LockState {
  const LockState({
    this.isEnabled = false,
    this.isLocked = false,
    this.lockType,
    this.isLoading = true,
  });

  final bool isEnabled;
  final bool isLocked;
  final String? lockType;
  final bool isLoading;

  LockState copyWith({
    bool? isEnabled,
    bool? isLocked,
    Object? lockType = _lockTypeUnset,
    bool? isLoading,
  }) {
    return LockState(
      isEnabled: isEnabled ?? this.isEnabled,
      isLocked: isLocked ?? this.isLocked,
      lockType:
          identical(lockType, _lockTypeUnset) ? this.lockType : lockType as String?,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// Notifier for lock state.
class LockStateNotifier extends StateNotifier<LockState> {
  LockStateNotifier(this._service) : super(const LockState());

  final LockService _service;

  /// Hydrate lock state from the bootstrap flow.
  void hydrate({
    required bool isEnabled,
    required String? lockType,
  }) {
    state = state.copyWith(
      isEnabled: isEnabled,
      isLocked: isEnabled,
      lockType: lockType,
      isLoading: false,
    );
  }

  /// Enable lock with the given type.
  Future<void> enableLock(String type) async {
    await _service.setLockEnabled(true, type: type);
    state = state.copyWith(
      isEnabled: true,
      isLocked: true,
      lockType: type,
      isLoading: false,
    );
  }

  /// Disable lock.
  Future<void> disableLock() async {
    await _service.setLockEnabled(false);
    await _service.clearLockData();
    state = state.copyWith(
      isEnabled: false,
      isLocked: false,
      lockType: null,
      isLoading: false,
    );
  }

  /// Authenticate and unlock.
  Future<bool> authenticate() async {
    final success = await _service.authenticateWithFallback();
    if (success) {
      state = state.copyWith(isLocked: false);
    }
    return success;
  }

  /// Verify PIN and unlock.
  Future<bool> verifyPin(String pin) async {
    final success = await _service.verifyPin(pin);
    if (success) {
      state = state.copyWith(isLocked: false);
    }
    return success;
  }

  /// Set a new PIN.
  Future<void> setPin(String pin) async {
    await _service.setPin(pin);
  }

  /// Check if a PIN exists.
  Future<bool> hasPin() async {
    return _service.hasPin();
  }

  /// Check if biometric is available.
  Future<bool> isBiometricAvailable() async {
    return _service.isBiometricAvailable();
  }

  /// Get available biometric types.
  Future<List<BiometricType>> getAvailableBiometrics() async {
    return _service.getAvailableBiometrics();
  }

  /// Lock the app.
  void lock() {
    if (state.isEnabled) {
      state = state.copyWith(isLocked: true);
    }
  }

  /// Unlock the app.
  void unlock() {
    state = state.copyWith(isLocked: false);
  }
}

/// Provider for lock state.
final lockStateProvider =
    StateNotifierProvider<LockStateNotifier, LockState>((ref) {
  return LockStateNotifier(ref.watch(lockServiceProvider));
});
