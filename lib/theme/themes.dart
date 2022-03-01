import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool get isDarkMode => themeMode == ThemeMode.dark;
  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
      fontFamily: 'AbhayaLibre',
      scaffoldBackgroundColor: const Color.fromRGBO(25, 20, 20, 100),
      buttonTheme: const ButtonThemeData(buttonColor: Colors.black54),
      primaryColor: Colors.black,
      cardColor: Colors.white,
      splashColor: Colors.white38,
      primaryIconTheme: const IconThemeData(color: Colors.white54),
      colorScheme: const ColorScheme.dark(),
      hintColor: Colors.black54,
      iconTheme: const IconThemeData(color: Colors.white));
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromRGBO(25, 20, 20, 100),
    primaryColor: Colors.white,
    cardColor: Colors.black,
    splashColor: Colors.black38,
    primaryIconTheme: const IconThemeData(color: Colors.black54),
    colorScheme: const ColorScheme.light(),
    hintColor: Colors.white54,
    iconTheme: const IconThemeData(color: Colors.black),
  );
}
