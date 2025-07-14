import 'package:kredo/model/authuser.dart';

abstract class TrxProvider{
  Future<List<Transaction>> get transactions;
  Future<void> addTransaction(Transaction transaction);
 }