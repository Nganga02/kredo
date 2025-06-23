import 'package:flutter/material.dart';
import 'package:kredo/repository/auth_repositoty.dart';
import 'package:kredo/screens/home.dart';
import 'package:kredo/screens/login.dart';
import 'package:kredo/utilities/authuser.dart';
import 'package:kredo/widgets/email_verification.dart';

import 'package:kredo/screens/loading.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key, required this.title});

  final String title;

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  /*
  These are the variables used in the following class state
  @Author: Ng'ang'a
  */
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPass;
  late final TextEditingController _phoneNumber;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPass = TextEditingController();
    _phoneNumber = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPass.dispose();
    _phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: FutureBuilder(
          future: FirebaseAuthRepository.build().initialize(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                final EmailAuthUser? emailAuthUser =
                    FirebaseAuthRepository.build().currentEmailUser!;
                if (emailAuthUser != null) {
                  if (emailAuthUser.isEmailVerified) {
                    return HomeScreen();
                  } else {
                    return Scaffold(
                      body: Center(
                        child: emailVerificationDialog(context, FirebaseAuthRepository.build().sendEmailVerification) as Widget,
                      ),
                    );
                  }
                }else{
                  return LoginScreen(title: "Swipe");
                }
              default:
                return LoadingScreen();
            }
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
