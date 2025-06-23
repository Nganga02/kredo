import 'package:flutter/material.dart';

Future<void> emailVerificationDialog(BuildContext context, Future<void> function() ) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Icon(Icons.warning_amber_rounded,
          color: Colors.green.shade700,
        ),
        content: Text("Registration was successful. Please verify your email address to continue."),
        actions: [
          TextButton(
            onPressed: () {
              function();
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}