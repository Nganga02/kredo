import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kredo/repository/auth_repositoty.dart';
import 'package:kredo/screens/loading.dart';
import 'package:kredo/widgets/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool seePass = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget logo = SvgPicture.asset('assets/images/logo.svg', semanticsLabel: 'Logo',);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              LoadingScreen(),
              Text("Login",
                style: TextTheme.of(context).headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              PassTextField(
                key: ValueKey("loginPass"),
                hintText: "Enter your password",
                password: _password,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    FirebaseAuthRepository.build().logIn(
                      email: email,
                      password: password,
                    );
                    print(
                      """\n This is the user****************
                ${FirebaseAuthRepository.build().currentEmailUser!.isEmailVerified} """,
                    );
        
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home',
                      (Route<dynamic> route) => false,
                    );
                  } catch (e) {

                  }
                },
                child: Text("Sign In"),
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
                        '/registration',
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      "Sign Up",
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
