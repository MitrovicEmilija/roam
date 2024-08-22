import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class Pallete {
  static const blue = Color.fromRGBO(38, 98, 203, 1);
  static const lightBlue = Color.fromRGBO(230, 235, 243, 1);
  static const white = Colors.white;
  static const yellow = Color.fromRGBO(251, 187, 0, 1);
  static const green = Color.fromRGBO(27, 87, 85, 1);
  static const lightGreen = Color.fromRGBO(27, 87, 85, 0.65);
  static const greyField = Color.fromRGBO(242, 240, 240, 1);
  static const greyText = Color.fromRGBO(128, 128, 128, 1);

  static var lightModeAppTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: lightGreen,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: lightBlue,
      shadowColor: lightGreen,
    ),
    primaryColor: blue,
    primaryColorDark: lightGreen,
    primaryIconTheme: const IconThemeData(color: blue),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          color: lightGreen,
          fontSize: 24,
          fontWeight: FontWeight.bold), // Adjust size and weight as needed
      displayMedium: TextStyle(
          color: lightGreen, fontSize: 22, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(
          color: lightGreen, fontSize: 20, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(
          color: lightGreen, fontSize: 18, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          color: lightGreen, fontSize: 14, fontWeight: FontWeight.bold),
      titleMedium:
          TextStyle(color: lightGreen, fontSize: 16), // Adjust size as needed
      titleSmall: TextStyle(color: lightGreen, fontSize: 14),
      bodyLarge: TextStyle(color: lightGreen, fontSize: 16),
      bodyMedium: TextStyle(color: lightGreen, fontSize: 14),
      labelLarge: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold), // Button text color is white
      bodySmall: TextStyle(color: lightGreen, fontSize: 12),
      labelSmall: TextStyle(color: lightGreen, fontSize: 10),
    ),
    cardTheme: const CardTheme(color: lightGreen),
  );

  static var darkModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color.fromARGB(255, 5, 38, 65),
    cardColor: const Color.fromARGB(255, 9, 56, 95),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 9, 56, 95),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromARGB(255, 20, 52, 79),
      shadowColor: Colors.white,
    ),
    primaryColor: Colors.white,
    primaryIconTheme: const IconThemeData(color: blue),
    primaryColorDark: blue,
    highlightColor: Colors.white,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold), // Adjust size and weight as needed
      displayMedium: TextStyle(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      titleMedium:
          TextStyle(color: Colors.white, fontSize: 16), // Adjust size as needed
      titleSmall: TextStyle(color: Colors.white, fontSize: 14),
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.white, fontSize: 14),
      labelLarge: TextStyle(
          color: blue,
          fontSize: 16,
          fontWeight: FontWeight.bold), // Button text color is blue
      bodySmall: TextStyle(color: Colors.white, fontSize: 12),
      labelSmall: TextStyle(color: Colors.white, fontSize: 10),
    ),
    cardTheme: const CardTheme(color: Colors.white),
    colorScheme: const ColorScheme(
      brightness: Brightness.light, // or Brightness.dark for a dark theme
      primary: Colors.blue, // Main color for the app
      onPrimary: Colors.white, // Color for text/icons on the primary color
      secondary: Colors.green, // Secondary color for accenting
      onSecondary: Colors.black, // Color for text/icons on the secondary color
      background: Colors.white, // Background color of the app
      onBackground:
          Colors.black, // Color for text/icons on the background color
      surface: Colors.white, // Color for surfaces like cards, sheets, etc.
      onSurface: Colors.black, // Color for text/icons on surfaces
      error: Colors.red, // Color for error states
      onError: Colors.white, // Color for text/icons on error color
      outline: Colors.grey, // Variants of the secondary color
    ),
  );
}

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeMode _mode;

  ThemeNotifier({ThemeMode mode = ThemeMode.dark})
      : _mode = mode,
        super(
          Pallete.darkModeAppTheme,
        ) {
    getTheme();
  }

  ThemeMode get mode => _mode;

  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');

    if (theme == 'light') {
      _mode = ThemeMode.light;
      state = Pallete.lightModeAppTheme;
    } else {
      _mode = ThemeMode.dark;
      state = Pallete.darkModeAppTheme;
    }
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_mode == ThemeMode.dark) {
      _mode = ThemeMode.light;
      state = Pallete.lightModeAppTheme;
      prefs.setString('theme', 'light');
    } else {
      _mode = ThemeMode.dark;
      state = Pallete.darkModeAppTheme;
      prefs.setString('theme', 'dark');
    }
  }
}
