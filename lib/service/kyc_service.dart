import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kredo/model/authuser.dart';
import 'package:kredo/provider/kyc_provider.dart';


class KycService implements KycProvider{
  final String number;
  KycService(this.number);
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  RegisteredUser? _cachedUser;

  Future<RegisteredUser> _fetchCredentials(String number) async {
    if(_cachedUser != null) return _cachedUser!;
    try {
      final value = await _database.collection('kyc').doc(number).get();
      _cachedUser = RegisteredUser(balance: value['balance'],
          id: value['id'],
          phoneNumber: value.id,
          displayName: value['displayName']);
      return _cachedUser!;
    } on FirebaseException catch (e) {
      print(e.code);
      rethrow;
    }
  }
  @override
  Future<String> get id async => (await _fetchCredentials(number)).id;


  @override
  Future<int> get balance async => (await _fetchCredentials(number)).balance;

  @override
  Future<String> get displayName async => (await _fetchCredentials(number)).displayName;

}