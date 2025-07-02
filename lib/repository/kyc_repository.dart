import 'package:kredo/model/authuser.dart';
import 'package:kredo/provider/kyc_provider.dart';

import '../service/kyc_service.dart';

class KycRepository implements KycProvider{
  final KycProvider kycProvider;
  const KycRepository(this.kycProvider);

  factory KycRepository.build(String number) => KycRepository(KycService(number));
  @override
  Future<int> get balance => kycProvider.balance;

  @override
  Future<String> get displayName => kycProvider.displayName;

  @override
  Future<String> get id => kycProvider.id;

  @override
  Future<bool> updateCustomerKyc({required RegisteredUser user}) => kycProvider.updateCustomerKyc(user: user);
}