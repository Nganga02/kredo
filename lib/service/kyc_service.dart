import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kredo/model/authuser.dart';
import 'package:kredo/provider/kyc_provider.dart';

class KycService implements KycProvider {
  final String number;
  KycService(this.number);
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  RegisteredUser? _cachedUser;

  Future<RegisteredUser> _fetchCredentials() async {
    if (_cachedUser != null) {
      return _cachedUser!;
    } else {
      try {
        final value = await _database.collection('kyc').doc(number).get();
        if (value.exists && value.data() != null) {
          try {
            _cachedUser = RegisteredUser(
              balance: value.data()!['balance'],
              id: value.data()!['id'],
              phoneNumber: value.id,
              displayName: value.data()!['name'],
            );
          } catch (e) {
            print("This is the error ${e.toString()}");
          }
        } else {
          print("There is no data for the following number $number");
        }
        return _cachedUser!;
      } on FirebaseException catch (e) {
        print("This is the firebase error message ${e.code}");
        rethrow;
      }
    }
  }

  @override
  Future<String> get id async {
    return (await _fetchCredentials()).id;
  }

  @override
  Future<int> get balance async => (await _fetchCredentials()).balance;



  @override
  Future<String> get displayName async =>
      (await _fetchCredentials()).displayName;

  @override
  Future<bool> updateCustomerKyc({required RegisteredUser user}) async {
    final DocumentReference transactionRef = _database
        .collection('transactions')
        .doc(user.phoneNumber); // You can use UID or phoneNumber for uniqueness
    try{
      await _database.collection('kyc').doc(user.phoneNumber).set({
        'id': user.id,
        'name': user.displayName,
        'balance': user.balance,
        'transactions': transactionRef,
      });
      return true;
    }on FirebaseException catch (e){
      print("This is the firebase error message ${e.code}");
      rethrow;
    }
  }
}
