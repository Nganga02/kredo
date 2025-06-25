import 'package:kredo/model/authuser.dart';

abstract class FirebaseAuthProvider {
  Future<void> initialize();
  /*
    Phone Auth
  */
  PhoneAuthUser? get currentPhoneUser;

  Future<PhoneAuthUser> registerPhoneNumber({
    required String phoneNumber,
    required String verificationId,
  });

  Future<PhoneAuthUser> verifyPhone({required String phoneNumber});

  Future<void> sendSMSCode();

  /*
    Email Auth
  */
  EmailAuthUser? get currentEmailUser;

  String? get displayName;

  Future<EmailAuthUser> logIn({
    required String email,
    required String password,
  });

  Future<EmailAuthUser> createEmailUser({
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
  });

  Future<void> sendEmailVerification();
  Future<void> signOut();
}
