import 'package:flutter/material.dart';
import 'package:kredo/repository/auth_repositoty.dart';
import 'package:kredo/repository/kyc_repository.dart';
import 'package:kredo/repository/trx_repository.dart';
import 'package:kredo/widgets/grid_button.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key, required this.onTap, required this.currentIndex});

  void Function(int)? onTap;
  int? currentIndex;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Center(
                    child: Text(
                      FirebaseAuthRepository.build().displayName![0],
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  "Hello ${FirebaseAuthRepository.build().displayName!}  👋",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.grey.shade900.withAlpha(80),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Balance",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    FutureBuilder<int>(
                      future: KycRepository.build('+254746011197').balance,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(''); // Or a loading text
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else if (snapshot.hasData) {
                          return Text(
                            "KES. ${snapshot.data}",
                            style: Theme.of(context).textTheme.titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.green.shade700,
                                ),
                          );
                        } else {
                          return const Text("No data");
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 1.2,
                children: [
                  GridButton(buttonName: "Buy Airtime", page: '/airtime'),
                  GridButton(buttonName: "Buy Bulk Airtime", page: '/airtime'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Recent",
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            FutureBuilder<List<dynamic>>(
              future: TrxRepository.build('+254746011197').transactions,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else if (snapshot.hasError) {
                  return Container();
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Container();
                } else {
                  return Expanded(
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            setState(() {
                              widget.onTap!(1);
                            });
                          },
                          title: Text(
                            'Ksh. ${snapshot.data![0].amount.toString()}',
                          ),
                          subtitle: Text(snapshot.data![0].time),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
