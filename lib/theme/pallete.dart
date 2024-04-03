import 'package:flutter/material.dart';

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
    scaffoldBackgroundColor: white,
    cardColor: white,
    appBarTheme: const AppBarTheme(
      backgroundColor: white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: blue,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: lightBlue,
    ),
    primaryColor: blue,
    backgroundColor: white,
  );
}
