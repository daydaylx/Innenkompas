import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:innenkompass/domain/services/lock_service.dart';

void main() {
  group('LockService', () {
    test('stores hashed pins instead of plaintext', () async {
      final store = _InMemorySecureStore();
      final service = LockService(
        localAuth: _FakeBiometricAuthenticator(),
        secureStorage: store,
      );

      await service.setPin('1234');

      final storedPin = await store.read(key: 'app_lock_pin');
      expect(storedPin, isNotNull);
      expect(storedPin, isNot('1234'));
      expect(storedPin, startsWith('sha256:'));
      expect(await service.verifyPin('1234'), isTrue);
    });

    test('migrates legacy plaintext pins after a successful verification',
        () async {
      final store = _InMemorySecureStore()..values['app_lock_pin'] = '9876';
      final service = LockService(
        localAuth: _FakeBiometricAuthenticator(),
        secureStorage: store,
      );

      expect(await service.verifyPin('9876'), isTrue);

      final migratedPin = await store.read(key: 'app_lock_pin');
      expect(migratedPin, isNotNull);
      expect(migratedPin, isNot('9876'));
      expect(migratedPin, startsWith('sha256:'));
    });

    test('returns false for incorrect pins', () async {
      final store = _InMemorySecureStore();
      final service = LockService(
        localAuth: _FakeBiometricAuthenticator(),
        secureStorage: store,
      );

      await service.setPin('1357');

      expect(await service.verifyPin('2468'), isFalse);
    });
  });
}

class _FakeBiometricAuthenticator implements BiometricAuthenticator {
  @override
  Future<bool> get canCheckBiometrics async => true;

  @override
  Future<bool> authenticate({required String localizedReason}) async {
    return true;
  }

  @override
  Future<List<BiometricType>> getAvailableBiometrics() async {
    return const [BiometricType.strong];
  }

  @override
  Future<bool> isDeviceSupported() async {
    return true;
  }
}

class _InMemorySecureStore implements SecureKeyValueStore {
  final Map<String, String?> values = <String, String?>{};

  @override
  Future<void> delete({required String key}) async {
    values.remove(key);
  }

  @override
  Future<String?> read({required String key}) async {
    return values[key];
  }

  @override
  Future<void> write({
    required String key,
    required String? value,
  }) async {
    values[key] = value;
  }
}
