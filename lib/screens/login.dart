import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kredo/repository/auth_repositoty.dart';
import 'package:kredo/screens/loading.dart';
import 'package:kredo/utilities/information_window.dart';
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
  bool isLoading = false;

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
    isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget logo = SvgPicture.asset(
      'assets/images/logo.svg',
      semanticsLabel: 'Logo',
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 40),
                LoadingScreen(),
                Text(
                  "Login",
                  style: TextTheme.of(
                    context,
                  ).headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
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
                      setState(() {
                        isLoading = true;
                      });
                      await FirebaseAuthRepository.build().logIn(
                        email: email,
                        password: password,
                      );
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home',
                        (Route<dynamic> route) => false,
                      );
                    } catch (e) {
                      showErrorDialog(context, e.toString());
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
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
