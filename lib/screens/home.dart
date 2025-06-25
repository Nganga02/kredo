import 'package:flutter/material.dart';
import 'package:kredo/repository/local_auth_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final bool _shouldLogin;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: LocalAuthRepository.build().authenticate(
          message: "message",
          fallbackLabel: "fallbackLabel",
        ),
        builder: (context, snapshot) {
          return Text("data");
        },
      ),
    );
  }
}
