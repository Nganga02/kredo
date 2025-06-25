import 'package:local_auth/local_auth.dart' show BiometricType;

abstract class LocalAuthProvider {
  Future<bool> isBiometricAvailable();

  Future<List<BiometricType>> get availableBiometrics;

  Future<bool> authenticate({
    required String message,
    required String fallbackLabel,
  });
}
