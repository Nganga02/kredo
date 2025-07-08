import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/landing.dart';
import '../constants/pageroutes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Lock orientation to portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'White Text UI',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white, // Light deep green
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
          bodyLarge: TextStyle(color: Colors.black),
          titleLarge: TextStyle(color: Colors.black),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green.shade700,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade700,
            foregroundColor: Colors.white,
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color.fromRGBO(240, 240, 240, 1),
          type: BottomNavigationBarType.shifting,
          selectedLabelStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          selectedIconTheme: IconThemeData(
            color: Colors.green.shade700,
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.black,),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade700,
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color.fromRGBO(10, 10, 10, 1),
          type: BottomNavigationBarType.shifting,
          selectedLabelStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          selectedIconTheme: IconThemeData(
            color: Colors.green.shade700,
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.grey,),
        ),
      ),
      themeMode: ThemeMode.system,
      routes: routes, // Automatically switch based on system theme
      home: LandingScreen(title: "Swipe"),
    ),
  );
}


final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.green.shade700,
  colorScheme: ColorScheme.light(
    primary: Colors.green.shade700,
    secondary: Colors.green.shade400,
    surface: Colors.white,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onError: Colors.white, // Color used on error backgrounds
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.green.shade700,
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green.shade700,
      foregroundColor: Colors.white,
      textStyle: TextStyle(color: Colors.white),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.green.shade700,
      textStyle: TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.green.shade700,
      side: BorderSide(color: Colors.green.shade700),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green.shade700),
    ),
    labelStyle: TextStyle(color: Colors.green.shade700),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.green.shade700,
    foregroundColor: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFF0F0F0),
    type: BottomNavigationBarType.shifting,
    selectedItemColor: Colors.green.shade700,
    unselectedItemColor: Colors.black,
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    selectedIconTheme: IconThemeData(
      color: Colors.green.shade700,
    ),
    unselectedIconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  iconTheme: IconThemeData(color: Colors.green.shade700),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.black),
    bodyLarge: TextStyle(color: Colors.black),
    titleLarge: TextStyle(color: Colors.black),
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  primaryColor: Colors.green.shade700,
  colorScheme: ColorScheme.dark(
    primary: Colors.green.shade700,
    secondary: Colors.green.shade400,
    surface: Colors.black,
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onError: Colors.black, // Color used on error backgrounds
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green.shade700,
      foregroundColor: Colors.white,
      textStyle: TextStyle(color: Colors.white),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.green.shade400,
      textStyle: TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.green.shade400,
      side: BorderSide(color: Colors.green.shade400),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green.shade700),
    ),
    labelStyle: TextStyle(color: Colors.green.shade700),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.green.shade700,
    foregroundColor: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF101010),
    type: BottomNavigationBarType.shifting,
    selectedItemColor: Colors.green.shade700,
    unselectedItemColor: Colors.grey,
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    selectedIconTheme: IconThemeData(
      color: Colors.green.shade700,
    ),
    unselectedIconTheme: IconThemeData(
      color: Colors.grey,
    ),
  ),
  iconTheme: IconThemeData(color: Colors.white),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
  ),
);
