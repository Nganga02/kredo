import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:kredo/model/authuser.dart' show RegisteredUser;
import 'package:shared_preferences/shared_preferences.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system);

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  void setLight() => state = ThemeMode.light;
  void setDark() => state = ThemeMode.dark;
}

final themeModeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => ThemeNotifier(),
);

class RegisteredUserNotifier extends StateNotifier<RegisteredUser?> {
  static const _userKey = 'currentUser';

  RegisteredUserNotifier() : super(null) {
    _loadRegisteredUser();
  }

  Future<void> _loadRegisteredUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userKey);
    if (userData != null) {
      state = RegisteredUser.fromRawJson(userData);
    }
  }

  Future<void> setRegisteredUser(RegisteredUser user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, user.toRawJson());
    state = user;
  }

  Future<void> clearRegisteredUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    state = null;
  }
}

final registeredUserProvider =
    StateNotifierProvider<RegisteredUserNotifier, RegisteredUser?>(
      (ref) => RegisteredUserNotifier(),
    );

class AuthenticationNotifier extends StateNotifier<String> {
  AuthenticationNotifier() : super('');

  void updatePin(String pin) {
    state += pin;

    if(state.length == 4) {
      try{
        authenticate();
      } on Exception catch(e) {
        rethrow;
      }
    }
  }

  bool authenticate() {
    if (state == '1234') {
      return true;
    } else {
      throw Exception('Invalid Pin');
    }
  }
}

final authenticationProvider =
    StateNotifierProvider<AuthenticationNotifier, String>(
      (ref) => AuthenticationNotifier(),
    );
