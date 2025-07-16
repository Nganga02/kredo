import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kredo/provider/appstate_provider.dart' show registeredUserProvider;
import 'package:kredo/repository/auth_repositoty.dart';
import 'package:kredo/repository/kyc_repository.dart';
import 'package:kredo/screens/loading.dart';
import 'package:kredo/utilities/information_window.dart';
import 'package:kredo/widgets/email_verification.dart';
import 'package:kredo/widgets/textfield.dart';

import '../model/authuser.dart' show RegisteredUser;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key, required this.title});

  final String title;

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  /*
  These are the variables used in the following class state
  @Author: Ng'ang'a
  */
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPass;
  late final TextEditingController _phoneNumber;
  late final TextEditingController _name;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPass = TextEditingController();
    _phoneNumber = TextEditingController();
    _name = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPass.dispose();
    _phoneNumber.dispose();
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              LoadingScreen(),
              Text(
                "Registration",
                style: TextTheme.of(
                  context,
                ).headlineSmall!.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: _phoneNumber,
                  cursorColor: Colors.green.shade700,
                  cursorErrorColor: Colors.red,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "exp: +254 712 345 678",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.green.shade700,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: _name,
                  cursorColor: Colors.green.shade700,
                  cursorErrorColor: Colors.red,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.green.shade700,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: _email,
                  cursorColor: Colors.green.shade700,
                  cursorErrorColor: Colors.red,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.green.shade700,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              PassTextField(
                key: ValueKey("signUpPass"),
                hintText: "Enter your password",
                password: _password,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10),
              PassTextField(
                key: ValueKey("signUpConfirmPass"),
                hintText: "Enter your password",
                password: _confirmPass,
                keyboardType: TextInputType.text,
              ),

              SizedBox(height: 40),
              Consumer(
                builder: (context, ref, child) {
                  final setRegisteredUser = ref.read(registeredUserProvider.notifier);
                  return  ElevatedButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      final confirmPass = _confirmPass.text;
                      final phoneNumber = _phoneNumber.text;
                      final name = _name.text;
                      try {
                        await FirebaseAuthRepository.build().createEmailUser(
                          email: email,
                          name: name,
                          password: password,
                          confirmPassword: confirmPass,
                          phoneNumber: phoneNumber,
                        );
                        await KycRepository.build(phoneNumber).updateCustomerKyc(
                          user: RegisteredUser(
                            balance: 0,
                            id: "XXXXXXXXX",
                            phoneNumber: phoneNumber,
                            displayName: name,
                          ),
                        );
                        setRegisteredUser.setRegisteredUser(RegisteredUser(
                          balance: 0,
                          id: "XXXXXXXXX",
                          phoneNumber: phoneNumber,
                          displayName: name,));
                        await emailVerificationDialog(
                          context,
                          FirebaseAuthRepository.build().sendEmailVerification,
                        );
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login',
                              (Route<dynamic> route) => false,
                        );
                      } catch (e) {
                        await showErrorDialog(context, e.toString());
                      }
                    },
                    child: Text("Sign up"),
                  );

                }

              ),
              SizedBox(height: 40),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not yet registered?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/login',
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      "Sign In",
                      style: TextTheme.of(context).bodyMedium!.copyWith(
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
