import 'package:kredo/model/authuser.dart';

abstract class KycProvider{
  Future<bool> updateCustomerKyc({required RegisteredUser user});
  Future<String> get id;
  Future<int> get balance;
  Future<String> get displayName;
}