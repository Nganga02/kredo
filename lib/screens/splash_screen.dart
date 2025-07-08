import 'package:flutter/material.dart';
import 'package:kredo/repository/local_auth_repository.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.child});

  final Widget child;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  AppLifecycleState? _notification;
  bool _isAuthenticated = false;
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _authenticate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    _notification = state;

    if (_notification == AppLifecycleState.resumed) {
      print("This is the value of notification: %%%%%%%% $_notification");
      if (!_isAuthenticated) {
        await _authenticate();
      } else {
        if (mounted) setState(() {});
      }
    } else if (_notification == AppLifecycleState.inactive) {
      setState(() {
        _isAuthenticated = false;
      }); //reset authentication status on inactive
      print(
        "\n This is the value of _isAuthenticated: %%%%%%%% $_isAuthenticated",
      );
    }
  }

  Future<void> _authenticate() async {
    if (_isAuthenticating) return;
    _isAuthenticating = true;

    final success = await LocalAuthRepository.build().authenticate(
      message: "Re-authenticate to continue",
      fallbackLabel: "Use PIN",
    );

    if (!mounted) return; // Prevent calling setState if widget is disposed

    if (success) {
      print('This is the value of success: ^^^^^^^^^^^^^^^^ $success');
      setState(() {
        _isAuthenticated = success;
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuilding with _isAuthenticated = $_isAuthenticated");
    if (!_isAuthenticated) {
      return Scaffold();
    } else {
      return widget.child;
    }
  }
}
