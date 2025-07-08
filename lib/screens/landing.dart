import 'package:flutter/material.dart';
import 'package:kredo/repository/auth_repositoty.dart';
import 'package:kredo/screens/home.dart';
import 'package:kredo/screens/splash_screen.dart';
import 'package:kredo/screens/login.dart';
import 'package:kredo/model/authuser.dart';
import 'package:kredo/widgets/email_verification.dart';

import 'package:kredo/screens/loading.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key, required this.title});

  final String title;

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: FirebaseAuthRepository.build().initialize(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                final EmailAuthUser? emailAuthUser =
                    FirebaseAuthRepository.build().currentEmailUser;
                if (emailAuthUser != null) {
                  if (emailAuthUser.isEmailVerified) {
                    return const SplashScreen(child: HomeScreen());
                  } else {
                    return const EmailVerificationScreen();
                  }
                } else {
                  return const LoginScreen(title: "Swipe");
                }
              default:
                return const Scaffold(
                  body: LoadingScreen(),
                );
            }
          },
        );
  }
}
