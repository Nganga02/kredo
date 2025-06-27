import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kredo/repository/local_auth_repository.dart';
import 'package:kredo/screens/home.dart';
import 'package:kredo/widgets/navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool _shouldLogin;

  @override
  void initState() {
    _shouldLogin = true;
    super.initState();
  }

  @override
  void dispose() {
    _shouldLogin = false;
    super.dispose();
  }

  void _exitApp() {
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: LocalAuthRepository.build().authenticate(
          message: "message",
          fallbackLabel: "fallbackLabel",
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasData && snapshot.data == true) {
            // Auth successful → go to home
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => HomeScreen()),
              );
            });
            return const SizedBox.shrink(); // Prevents rebuilding a screen
          } else {
            // Auth failed → exit or retry
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _exitApp();
            });
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
