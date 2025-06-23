import 'package:flutter/material.dart';
import 'package:kredo/screens/home.dart';
import 'package:kredo/screens/login.dart';
import 'package:kredo/screens/landing.dart';
import 'package:kredo/screens/registration.dart';

Map<String, Widget Function(BuildContext context)>routes = {
  '/root': (context) => LandingScreen(title: "Swipe"),
  '/login' : (context) => LoginScreen(title: "Swipe"),
  '/home' : (context) => HomeScreen(),
  '/registration' : (context) => RegistrationScreen(title: "Swipe"),)
};