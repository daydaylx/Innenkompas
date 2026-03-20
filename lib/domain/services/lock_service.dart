import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

abstract class BiometricAuthenticator {
  Future<bool> get canCheckBiometrics;

  Future<bool> isDeviceSupported();

  Future<List<BiometricType>> getAvailableBiometrics();

  Future<bool> authenticate({required String localizedReason});
}

class LocalBiometricAuthenticator implements BiometricAuthenticator {
  LocalBiometricAuthenticator(this._localAuth);

  final LocalAuthentication _localAuth;

  @override
  Future<bool> get canCheckBiometrics => _localAuth.canCheckBiometrics;

  @override
  Future<bool> isDeviceSupported() => _localAuth.isDeviceSupported();

  @override
  Future<List<BiometricType>> getAvailableBiometrics() =>
      _localAuth.getAvailableBiometrics();

  @override
  Future<bool> authenticate({required String localizedReason}) {
    return _localAuth.authenticate(
      localizedReason: localizedReason,
      options: const AuthenticationOptions(
        stickyAuth: true,
        biometricOnly: false,
      ),
    );
  }
}

abstract class SecureKeyValueStore {
  Future<void> write({
    required String key,
    required String? value,
  });

  Future<String?> read({required String key});

  Future<void> delete({required String key});
}

class FlutterSecureKeyValueStore implements SecureKeyValueStore {
  FlutterSecureKeyValueStore(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<void> write({
    required String key,
    required String? value,
  }) {
    return _storage.write(key: key, value: value);
  }

  @override
  Future<String?> read({required String key}) {
    return _storage.read(key: key);
  }

  @override
  Future<void> delete({required String key}) {
    return _storage.delete(key: key);
  }
}

/// Service for managing app lock via biometrics or PIN.
class LockService {
  LockService({
    required BiometricAuthenticator localAuth,
    required SecureKeyValueStore secureStorage,
  })  : _localAuth = localAuth,
        _secureStorage = secureStorage;

  final BiometricAuthenticator _localAuth;
  final SecureKeyValueStore _secureStorage;

  static const String _pinKey = 'app_lock_pin';
  static const String _lockEnabledKey = 'app_lock_enabled';
  static const String _lockTypeKey = 'app_lock_type';
  static const String _hashedPinPrefix = 'sha256:';

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
      return await _localAuth.authenticate(localizedReason: reason);
    } on PlatformException {
      return false;
    }
  }

  /// Set a PIN for app lock.
  Future<void> setPin(String pin) async {
    try {
      await _secureStorage.write(key: _pinKey, value: _hashPin(pin));
    } on PlatformException {
      // Ignore storage failures; callers handle unavailable lock setup.
    } on MissingPluginException {
      // Tests and unsupported platforms may not provide the plugin.
    }
  }

  /// Verify a PIN against the stored one.
  Future<bool> verifyPin(String pin) async {
    try {
      final storedPin = await _secureStorage.read(key: _pinKey);
      if (storedPin == null || storedPin.isEmpty) {
        return false;
      }

      final hashedPin = _hashPin(pin);
      if (storedPin == hashedPin) {
        return true;
      }

      final isLegacyPlaintextPin =
          !_isHashedPin(storedPin) && _constantTimeEquals(storedPin, pin);
      if (!isLegacyPlaintextPin) {
        return false;
      }

      await _secureStorage.write(key: _pinKey, value: hashedPin);
      return true;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  /// Check if a PIN has been set.
  Future<bool> hasPin() async {
    try {
      final pin = await _secureStorage.read(key: _pinKey);
      return pin != null && pin.isNotEmpty;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  /// Delete the stored PIN.
  Future<void> deletePin() async {
    try {
      await _secureStorage.delete(key: _pinKey);
    } on PlatformException {
      // Ignore storage failures on unsupported platforms.
    } on MissingPluginException {
      // Ignore storage failures on unsupported platforms.
    }
  }

  /// Check if app lock is enabled.
  Future<bool> isLockEnabled() async {
    try {
      final value = await _secureStorage.read(key: _lockEnabledKey);
      return value == 'true';
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  /// Set app lock enabled state.
  Future<void> setLockEnabled(bool enabled, {String? type}) async {
    try {
      await _secureStorage.write(
        key: _lockEnabledKey,
        value: enabled.toString(),
      );
      if (type != null) {
        await _secureStorage.write(key: _lockTypeKey, value: type);
      }
    } on PlatformException {
      // Ignore storage failures; callers treat lock setup as unavailable.
    } on MissingPluginException {
      // Ignore storage failures; callers treat lock setup as unavailable.
    }
  }

  /// Get the lock type ('biometric', 'pin', 'biometric_and_pin').
  Future<String?> getLockType() async {
    try {
      return _secureStorage.read(key: _lockTypeKey);
    } on PlatformException {
      return null;
    } on MissingPluginException {
      return null;
    }
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
    try {
      await _secureStorage.delete(key: _pinKey);
      await _secureStorage.delete(key: _lockEnabledKey);
      await _secureStorage.delete(key: _lockTypeKey);
    } on PlatformException {
      // Ignore storage failures on unsupported platforms.
    } on MissingPluginException {
      // Ignore storage failures on unsupported platforms.
    }
  }

  static String _hashPin(String pin) {
    final digest = sha256.convert(utf8.encode(pin));
    return '$_hashedPinPrefix$digest';
  }

  static bool _isHashedPin(String value) {
    return value.startsWith(_hashedPinPrefix);
  }

  static bool _constantTimeEquals(String a, String b) {
    if (a.length != b.length) return false;
    var result = 0;
    for (var i = 0; i < a.length; i++) {
      result |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return result == 0;
  }
}
