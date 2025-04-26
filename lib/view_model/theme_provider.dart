import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeProvider = ChangeNotifierProvider(
  (ref) => themeNotifier,
);

ThemeNotifier? _themeNotifier;

ThemeNotifier get themeNotifier {
  _themeNotifier ??= ThemeNotifier();
  return _themeNotifier!;
}

class ThemeNotifier extends ChangeNotifier {
  String currentTheme = "system";

  ThemeMode get themeMode {
    if (currentTheme == "light") {
      return ThemeMode.dark;
    }
    if (currentTheme == "dark") {
      return ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }

  init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    currentTheme = prefs.getString("theme") ?? "system";
    notifyListeners();
  }

  changeTheme(bool change) async {
    late String theme;
    if (change == true) {
      theme = "light";
    } else {
      theme = "dark";
    }
    currentTheme = theme;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("theme", theme);
    notifyListeners();
  }
}
