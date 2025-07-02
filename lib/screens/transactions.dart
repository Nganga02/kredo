import 'package:flutter/material.dart';
import 'package:kredo/repository/trx_repository.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              future: TrxRepository.build('+254746011197').transactions,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("");
                } else if (snapshot.hasError) {
                  return Text("");
                } else {
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
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
