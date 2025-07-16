import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

@immutable
class PhoneAuthUser {
  final bool isPhoneVerified;

  const PhoneAuthUser(this.isPhoneVerified);

  factory PhoneAuthUser.fromFirebase(User user) =>
      user.phoneNumber != null ? PhoneAuthUser(true) : PhoneAuthUser(false);
}

@immutable
class EmailAuthUser {
  final bool isEmailVerified;
  final String? displayName;
  final String? email;

  const EmailAuthUser(this.isEmailVerified, this.displayName, this.email);

  factory EmailAuthUser.fromFirebase(User user) =>
      EmailAuthUser(user.emailVerified, user.displayName, user.email);
}

@immutable
class RegisteredUser {
  final String id;
  final String phoneNumber;
  final String displayName;
  final int balance;

  const RegisteredUser({
    required this.balance,
    required this.id,
    required this.phoneNumber,
    required this.displayName,
  });

  factory RegisteredUser.fromJson(Map<String, dynamic> json) {
    return RegisteredUser(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      displayName: json['displayName'],
      balance: json['balance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'displayName': displayName,
      'balance': balance,
    };
  }

  String toRawJson() => jsonEncode(toJson());

  static RegisteredUser fromRawJson(String str) =>
      RegisteredUser.fromJson(jsonDecode(str));
}

class Transaction {
  final String time;
  final int amount;

  Transaction({required this.time, required this.amount});
}
