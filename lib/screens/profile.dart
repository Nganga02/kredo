import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kredo/repository/auth_repositoty.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(
                      context,
                    ).bottomNavigationBarTheme.backgroundColor,
                  ),
                  child: Center(
                    child: Text(
                      FirebaseAuthRepository.build().displayName![0],
                      style: GoogleFonts.abel(
                        textStyle: Theme.of(context).textTheme.titleLarge,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  "Hello ${FirebaseAuthRepository.build().displayName!}  👋",
                  style: GoogleFonts.abel(
                    textStyle: Theme.of(context).textTheme.titleMedium,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                  },
                  icon: Icon(
                    Theme.of(context).brightness == Brightness.dark
                        ? Icons.sunny
                        : Icons.dark_mode,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
