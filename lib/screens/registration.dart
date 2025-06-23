import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kredo/repository/auth_repositoty.dart';
import 'package:kredo/widgets/textfield.dart';

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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                'assets/images/logo.svg',
                height: 200,
              ),
              SizedBox(height: 40),
              Text("Registration",
                style: TextTheme.of(context).headlineMedium!.copyWith(
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
                key: ValueKey("signUpPass"),
                hintText: "Enter your password",
                password: _password,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10),
              PassTextField(
                key: ValueKey("signUpConfirmPass"),
                hintText: "Enter your password",
                password: _password,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 40),
              ElevatedButton(onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                final confirmPass = _confirmPass.text;
                try {
                  FirebaseAuthRepository.build().createEmailUser(email: email, password: password, confirmPassword: password);
                  Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                }catch (e){

                }
              }, child: Text("Sign In")),
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
