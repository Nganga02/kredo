import 'package:flutter/material.dart';
import 'package:kredo/widgets/airtime_button.dart';

class AirtimePurchaseScreen extends StatelessWidget {
  const AirtimePurchaseScreen({super.key});

  void _onTap(BuildContext context, String amount) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(20),
          clipBehavior: Clip.hardEdge,
          child: Center(
            child: Column(
              children: [
                Text("You are about to purchase Ksh. $amount"),
                SizedBox(height: 20),
                const Text("Confirm purchase"),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: const Text("Cancel")),
                    ElevatedButton(onPressed: () {
                      Navigator.of(context).pushNamed('/authScreen');
                    }, child:  const Text("Confirm")),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String?>;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ],
              ),
            ),
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
                  children: args.entries
                      .map(
                        (entry) => AirtimeButton(
                          amount: entry.key,
                          discount: entry.value,
                          onTap: _onTap,
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
