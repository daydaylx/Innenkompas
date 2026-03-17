import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

/// Service for managing app lock via biometrics or PIN.
class LockService {
  LockService({
    required LocalAuthentication localAuth,
    required FlutterSecureStorage secureStorage,
  })  : _localAuth = localAuth,
        _secureStorage = secureStorage;

  final LocalAuthentication _localAuth;
  final FlutterSecureStorage _secureStorage;

  static const String _pinKey = 'app_lock_pin';
  static const String _lockEnabledKey = 'app_lock_enabled';
  static const String _lockTypeKey = 'app_lock_type';

  /// Check if biometric authentication is available on this device.
  Future<bool> isBiometricAvailable() async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      return canCheck && isDeviceSupported;
    } on PlatformException {
      return false;
    }
  }

  /// Get the list of available biometric types.
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } on PlatformException {
      return [];
    }
  }

  /// Authenticate using biometrics.
  Future<bool> authenticate({String reason = 'Innenkompass entsperren'}) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );
    } on PlatformException {
      return false;
    }
  }

  /// Set a PIN for app lock.
  Future<void> setPin(String pin) async {
    await _secureStorage.write(key: _pinKey, value: pin);
  }

  /// Verify a PIN against the stored one.
  Future<bool> verifyPin(String pin) async {
    final storedPin = await _secureStorage.read(key: _pinKey);
    return storedPin == pin;
  }

  /// Check if a PIN has been set.
  Future<bool> hasPin() async {
    final pin = await _secureStorage.read(key: _pinKey);
    return pin != null && pin.isNotEmpty;
  }

  /// Delete the stored PIN.
  Future<void> deletePin() async {
    await _secureStorage.delete(key: _pinKey);
  }

  /// Check if app lock is enabled.
  Future<bool> isLockEnabled() async {
    final value = await _secureStorage.read(key: _lockEnabledKey);
    return value == 'true';
  }

  /// Set app lock enabled state.
  Future<void> setLockEnabled(bool enabled, {String? type}) async {
    await _secureStorage.write(
      key: _lockEnabledKey,
      value: enabled.toString(),
    );
    if (type != null) {
      await _secureStorage.write(key: _lockTypeKey, value: type);
    }
  }

  /// Get the lock type ('biometric', 'pin', 'biometric_and_pin').
  Future<String?> getLockType() async {
    return _secureStorage.read(key: _lockTypeKey);
  }

  /// Perform the full authentication flow.
  /// Returns true if authentication succeeds.
  Future<bool> authenticateWithFallback() async {
    final lockType = await getLockType();

    if (lockType == 'biometric' || lockType == 'biometric_and_pin') {
      final isAvailable = await isBiometricAvailable();
      if (isAvailable) {
        final success = await authenticate();
        if (success) return true;
        // If biometric fails and we have pin fallback, don't return false yet
        if (lockType != 'biometric_and_pin') return false;
      }
    }

    // For PIN-based or fallback, the PIN screen handles it
    return false;
  }

  /// Remove all lock data.
  Future<void> clearLockData() async {
    await _secureStorage.delete(key: _pinKey);
    await _secureStorage.delete(key: _lockEnabledKey);
    await _secureStorage.delete(key: _lockTypeKey);
  }
}
