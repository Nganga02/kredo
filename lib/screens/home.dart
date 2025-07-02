import 'package:flutter/material.dart';
import 'package:kredo/screens/profile.dart';
import 'package:kredo/screens/transactions.dart';
import 'package:kredo/screens/welcome.dart';
import 'package:kredo/widgets/navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedIndex = 0;

  void _currentIndex(int index){
    if(_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
    print(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          WelcomeScreen(onTap: _currentIndex, currentIndex: _selectedIndex,),
          TransactionScreen(),
          ProfileScreen(),
        ],

      ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _currentIndex,
        )
    );
  }
}
