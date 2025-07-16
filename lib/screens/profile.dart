import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
*This is the custom package section
*/
import 'package:google_fonts/google_fonts.dart';
import 'package:kredo/provider/appstate_provider.dart';
import 'package:kredo/repository/auth_repositoty.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setTheme = ref.read(themeModeProvider.notifier);
    final themeMode = ref.watch(themeModeProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
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
                    setTheme.toggleTheme();
                  },
                  icon: Icon(
                    Theme.of(context).brightness == Brightness.dark
                        ? Icons.sunny
                        : Icons.dark_mode,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              "ACCOUNT INFO",
              style: GoogleFonts.abel(
                textStyle: Theme.of(context).textTheme.bodyLarge,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
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
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              FirebaseAuthRepository.build().displayName!,
              style: Theme.of(context).textTheme.titleMedium
            ),
            SizedBox(height: 15),
            Text(
              FirebaseAuthRepository.build().email!,
              style: GoogleFonts.roboto(
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () async {
                  await FirebaseAuthRepository.build().signOut();
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                }, child: Text("Logout",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
