

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

  const EmailAuthUser(this.isEmailVerified);

  factory EmailAuthUser.fromFirebase(User user) => EmailAuthUser(user.emailVerified);

}