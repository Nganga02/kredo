import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
* This indicates the custom package.
*/
import 'package:kredo/screens/profile.dart';
import 'package:kredo/screens/transactions.dart';
import 'package:kredo/screens/welcome.dart';
import 'package:kredo/widgets/navigation_bar.dart';

/*
* This indicates the appstate provider
*/
import '../provider/appstate_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    final setIndex = ref.read(selectedIndexProvider.notifier);
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          WelcomeScreen(),
          TransactionScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}