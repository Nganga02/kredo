import 'package:flutter/material.dart';
import 'package:kredo/repository/auth_repositoty.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Email verification required before proceeding"),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuthRepository.build().sendEmailVerification();
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route route) => false);
            },
            child: Text("Send verification email"),
          ),
        ],
      ),
    );
  }
}

Future<void> emailVerificationDialog(
  BuildContext context,
  Future<void> function(),
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Icon(Icons.check_circle_outline, color: Colors.green.shade700),
        content: Text(
          "Registration was successful. Please verify your email address to continue.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              function();
              Navigator.of(context).pop();
            },
            child: const Text("Verify"),
          ),
        ],
      );
    },
  );
}
