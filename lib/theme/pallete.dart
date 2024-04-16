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
      headline1: TextStyle(
          color: lightGreen,
          fontSize: 24,
          fontWeight: FontWeight.bold), // Adjust size and weight as needed
      headline2: TextStyle(
          color: lightGreen, fontSize: 22, fontWeight: FontWeight.bold),
      headline3: TextStyle(
          color: lightGreen, fontSize: 20, fontWeight: FontWeight.bold),
      headline4: TextStyle(
          color: lightGreen, fontSize: 18, fontWeight: FontWeight.bold),
      headline5: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      headline6: TextStyle(
          color: lightGreen, fontSize: 14, fontWeight: FontWeight.bold),
      subtitle1:
          TextStyle(color: lightGreen, fontSize: 16), // Adjust size as needed
      subtitle2: TextStyle(color: lightGreen, fontSize: 14),
      bodyText1: TextStyle(color: lightGreen, fontSize: 16),
      bodyText2: TextStyle(color: lightGreen, fontSize: 14),
      button: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold), // Button text color is white
      caption: TextStyle(color: lightGreen, fontSize: 12),
      overline: TextStyle(color: lightGreen, fontSize: 10),
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
    backgroundColor: Colors.white,
    textTheme: const TextTheme(
      headline1: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold), // Adjust size and weight as needed
      headline2: TextStyle(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      headline3: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      headline4: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      headline5: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      headline6: TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      subtitle1:
          TextStyle(color: Colors.white, fontSize: 16), // Adjust size as needed
      subtitle2: TextStyle(color: Colors.white, fontSize: 14),
      bodyText1: TextStyle(color: Colors.white, fontSize: 16),
      bodyText2: TextStyle(color: Colors.white, fontSize: 14),
      button: TextStyle(
          color: blue,
          fontSize: 16,
          fontWeight: FontWeight.bold), // Button text color is blue
      caption: TextStyle(color: Colors.white, fontSize: 12),
      overline: TextStyle(color: Colors.white, fontSize: 10),
    ),
    cardTheme: const CardTheme(color: Colors.white),
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
