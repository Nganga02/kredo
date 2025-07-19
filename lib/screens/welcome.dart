import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

/*
* This indicates the custom package.
*/
import 'package:kredo/model/airtime_deno.dart';
import 'package:kredo/provider/appstate_provider.dart';
import 'package:kredo/repository/auth_repositoty.dart';
import 'package:kredo/repository/kyc_repository.dart';
import 'package:kredo/repository/trx_repository.dart';
import 'package:kredo/widgets/grid_button.dart';

class WelcomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setIndex = ref.read(selectedIndexProvider.notifier);
    final registeredUser = ref.watch(registeredUserProvider);
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
                    color: Theme.of(
                      context,
                    ).bottomNavigationBarTheme.backgroundColor,
                  ),
                  child: Center(
                    child: Text(
                      FirebaseAuthRepository.build().displayName![0],
                      style: GoogleFonts.abel(
                        textStyle: Theme.of(context).textTheme.titleLarge,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  "Hello ${FirebaseAuthRepository.build().displayName!}  👋",
                  style: GoogleFonts.abel(
                    textStyle: Theme.of(context).textTheme.titleMedium,
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
                color: Theme.of(
                  context,
                ).bottomNavigationBarTheme.backgroundColor,
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
                      future: KycRepository.build(
                        registeredUser!.phoneNumber,
                      ).balance,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(''); // Or a loading text
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else if (snapshot.hasData) {
                          return Text(
                            "KES. ${snapshot.data}",
                            style: GoogleFonts.dmSerifText(
                              textStyle: Theme.of(context).textTheme.titleLarge,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        } else {
                          return const Text("No transactions yet");
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 150,
              child: Row(
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      physics: NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.2,
                      children: [
                        GridButton(
                          buttonName: "Buy Airtime",
                          page: '/airtime',
                          denominations: airtimes,
                        ),
                        GridButton(
                          buttonName: "Buy Bulk Airtime",
                          page: '/airtime',
                          denominations: bulk_airtime,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Recent",
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.titleMedium,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder<List<dynamic>>(
              future: TrxRepository.build(
                registeredUser.phoneNumber,
              ).transactions,
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
                            setIndex.state = 1;
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
