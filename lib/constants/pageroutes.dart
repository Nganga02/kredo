import 'package:flutter/material.dart';

import 'package:kredo/screens/airtime_purchase.dart';
import 'package:kredo/screens/authentication.dart';
import 'package:kredo/screens/home.dart';
import 'package:kredo/screens/profile.dart';
import 'package:kredo/screens/splash_screen.dart';
import 'package:kredo/screens/login.dart';
import 'package:kredo/screens/landing.dart';
import 'package:kredo/screens/registration.dart';
import 'package:kredo/screens/transactions.dart';
import 'package:kredo/screens/welcome.dart';

Map<String, Widget Function(BuildContext context)>routes = {
  '/root': (context) => LandingScreen(title: "Swipe"),
  '/login' : (context) => LoginScreen(title: "Swipe"),
  '/registration' : (context) => RegistrationScreen(title: "Swipe"),
  '/home' : (context) => SplashScreen(child: HomeScreen(),),
  '/profile' : (context) => ProfileScreen(),
  'transaction' : (context) => TransactionScreen(),
  '/welcome' : (context) => WelcomeScreen(),
  '/airtime' : (context) => AirtimePurchaseScreen(),
  '/bulkAirtime' : (context) => AirtimePurchaseScreen(),
  '/authScreen' : (context) => AuthenticationScreen(),
};