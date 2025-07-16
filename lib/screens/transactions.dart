import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kredo/repository/trx_repository.dart';

import '../provider/appstate_provider.dart' show registeredUserProvider;

class TransactionScreen extends ConsumerWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registeredUser = ref.watch(registeredUserProvider);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Text(
              "Recent Transactions",
              style: Theme.of(context).textTheme.titleLarge!,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: TrxRepository.build(registeredUser!.phoneNumber).transactions,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("");
                } else if (snapshot.hasError) {
                  return Text("");
                } else if(snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final transaction = snapshot.data![index];
                      return ListTile(
                        title: Text("KES. ${transaction.amount}"),
                        subtitle: Text(transaction.time),
                      );
                    },
                  );
                }else{
                  return Center(
                    child: Text("No transactions yet"),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
