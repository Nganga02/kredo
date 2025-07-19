import 'package:kredo/model/authuser.dart';


//This is an interface class
abstract class KycProvider{
  Future<bool> updateCustomerKyc({required RegisteredUser user});
  Future<String> get id;
  Future<int> get balance;
  Future<String> get displayName;
}