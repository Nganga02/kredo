import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
class PhoneAuthUser {
  final bool isPhoneVerified;

  const PhoneAuthUser(this.isPhoneVerified);

  factory PhoneAuthUser.fromFirebase(User user) => user.phoneNumber != null ? PhoneAuthUser(true) : PhoneAuthUser(false);
}


@immutable
class EmailAuthUser{
  final bool isEmailVerified;
  final String? displayName;

  const EmailAuthUser(this.isEmailVerified, this.displayName);

  factory EmailAuthUser.fromFirebase(User user) => EmailAuthUser(user.emailVerified, user.displayName);

}

@immutable
class RegisteredUser{
  final String id;
  final String phoneNumber;
  final String displayName;
  final int balance;

  const RegisteredUser({required this.balance, required this.id, required this.phoneNumber, required this.displayName});
}