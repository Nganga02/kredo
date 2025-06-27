import 'package:kredo/model/authuser.dart';

abstract class KycProvider{
  Future<String> get id;
  Future<int> get balance;
  Future<String> get displayName;
}