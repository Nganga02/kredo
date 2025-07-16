import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    print("\n \n The authentication page is being built&&&&&&&&&&&&&&&&&&&&&&&&\n\n");
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Text("Authentication Screen",
            style: GoogleFonts.abel(
              textStyle: Theme.of(context).textTheme.titleLarge,
              fontWeight: FontWeight.bold,
            )
          ),
            Text(
              "hello",
              style: GoogleFonts.abel()
            )
          ],
        ),
      ),
    );
  }
}
