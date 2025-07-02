import 'package:kredo/model/authuser.dart';
import 'package:kredo/provider/trx_provider.dart';
import 'package:kredo/service/trx_service.dart';

class TrxRepository implements TrxProvider{
  final TrxProvider trxProvider;
  const TrxRepository(this.trxProvider);
  factory TrxRepository.build(String number) => TrxRepository(TrxService(number));
  @override
  Future<List<Transaction>> get transactions => trxProvider.transactions;
}