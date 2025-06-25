import 'package:kredo/provider/local_auth_provider.dart';
import 'package:kredo/service/local_auth_service.dart';
import 'package:local_auth/local_auth.dart' show BiometricType;

class LocalAuthRepository implements LocalAuthProvider{
  final LocalAuthProvider localAuthProvider;
  const LocalAuthRepository(this.localAuthProvider);
  factory LocalAuthRepository.build() => LocalAuthRepository(LocalAuthService());

  @override
  Future<bool> authenticate({required String message, required String fallbackLabel}) => localAuthProvider.authenticate(message: message, fallbackLabel: fallbackLabel);

  @override
  // TODO: implement availableBiometrics
  Future<List<BiometricType>> get availableBiometrics => localAuthProvider.availableBiometrics;

  @override
  Future<bool> isBiometricAvailable() => localAuthProvider.isBiometricAvailable();}