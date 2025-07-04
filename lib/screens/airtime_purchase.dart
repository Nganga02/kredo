import 'package:flutter/material.dart';
import 'package:kredo/widgets/airtime_button.dart';

class AirtimePurchaseScreen extends StatelessWidget {
  const AirtimePurchaseScreen({super.key, required this.airtimes});

  final Map<String, String?> airtimes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 1,
                  children: airtimes.entries
                      .map(
                        (entry) => AirtimeButton(
                          amount: entry.key,
                          discount: entry.value,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
