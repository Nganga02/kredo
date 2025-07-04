import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kredo/model/authuser.dart' as trx show Transaction;
import 'package:kredo/provider/trx_provider.dart';
import 'package:intl/intl.dart';

class TrxService implements TrxProvider {
  final String number;
  TrxService(this.number);
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  Future<List<trx.Transaction>> _fetchTransactions() async {
    final List<trx.Transaction> transactions = [];
    try {
      final value = await _database.collection('kyc').doc(number).get();
      if (value.exists && value.data() != null) {
        try {
          final trxRef = value.data()!['transactions'];
          print('\n This s the document reference: $trxRef \n');
          try {
            final trxData = await trxRef.get();
            if (trxData.exists && trxData.data() != null) {
              trxData.data()!.forEach((time, data) {
                int year = int.parse(time.substring(0, 4));
                int month = int.parse(time.substring(4, 6));
                int day = int.parse(time.substring(6, 8));
                int hour = int.parse(time.substring(8, 10));
                int minute = int.parse(time.substring(10, 12));
                int second = int.parse(time.substring(12, 14));
                DateTime dateTime = DateTime(year, month, day, hour, minute, second);
                String formatted = DateFormat('dd MMMM HH:mm:ss').format(dateTime);
                transactions.add(
                  trx.Transaction(time: formatted, amount: data['amount']),
                );
              });
            }
          } on FirebaseException catch (e) {
            print("\n This is the doc ref error ${e.code}\n");
          }
        } catch (e) {
          print("This is the error ${e.toString()}");
        }
      } else {
        print("There is no data for the following number $number");
      }
      return transactions;
    } on FirebaseException catch (e) {
      print("This is the firebase error message ${e.code}");
      rethrow;
    }
  }

  @override
  Future<List<trx.Transaction>> get transactions async {
    print((await _fetchTransactions()));
    return (await _fetchTransactions());
  }
}
