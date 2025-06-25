import 'dart:io';

import 'package:flutter/services.dart';
import 'package:kredo/provider/local_auth_provider.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

import 'package:local_auth/local_auth.dart';

import '../utilities/auth_exceptions.dart';

class LocalAuthService implements LocalAuthProvider {
  @override
  Future<bool> authenticate({
    required String message,
    required String fallbackLabel,
  }) async {
    try {
      List<dynamic> biometrics = await availableBiometrics;
      final bool didAuthenticate = await LocalAuthentication().authenticate(
        localizedReason: 'Authentication needed',
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          stickyAuth: true,
        ),
      );
      return didAuthenticate;
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        throw BiometricNotEnrolledAuthException();
      } else if (e.code == auth_error.lockedOut ||
          e.code == auth_error.permanentlyLockedOut) {
        throw BiometricAuthException();
      } else {
        throw GenericAuthException();
      }
    }
  }

  @override
  // TODO: implement availableBiometrics
  Future<List<BiometricType>> get availableBiometrics async {
    final bool _isBiometricAvailable = await isBiometricAvailable();
    final List<BiometricType> availableBiometrics;
    if (_isBiometricAvailable) {
      availableBiometrics = await LocalAuthentication()
          .getAvailableBiometrics();
    } else {
      availableBiometrics = [];
    }
    return availableBiometrics;
  }

  @override
  Future<bool> isBiometricAvailable() async {
    try {
      final bool canAuthenticateWithBiometrics =
          await LocalAuthentication().canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics ||
          await LocalAuthentication().isDeviceSupported();

      return canAuthenticate;
    } catch (e) {
      stderr.writeln("This is the error that occured: $e");
      rethrow;
    }
  }
}
