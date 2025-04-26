import 'package:flutter/material.dart';

_ThemeApp? _appTheme;

_ThemeApp get theme {
  _appTheme ??= _ThemeApp();
  return _appTheme!;
}

void updateTheme() {
  _appTheme = _ThemeApp();
}

class _ThemeApp {
  Color tr = Colors.transparent;
  Color black = const Color(0xff000000);
  Color white = const Color(0xffffffff);
  Color blue = const Color(0xff1A87DD);
  Color yellow = const Color(0xffF8BB18);
  Color greyAccent = const Color(0xffBEBCBC);
  Color greyAccent2 = const Color(0xffF3F4F5);
  Color grey = Colors.grey;

//All fonts
  String fontAbys = "Abys";

  TextStyle testStyle = const TextStyle(
    color: Color(0xff000000),
    overflow: TextOverflow.ellipsis,
    decoration: TextDecoration.none,
    fontFamily: "Inter",
  );

  ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xffffffff),
    primaryColorDark: Color(0xff000000),
    primaryColor: Color(0xff1A87DD),
    cardColor: Color(0xff000000),
    canvasColor: Color(0xff1A87DD),
    focusColor: Color(0xffF3F4F5),
    useMaterial3: true,
  );

  ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xff1F303E),
    primaryColorDark: Color(0xffffffff),
    primaryColor: Color(0xff1F303E),
    cardColor: Color(0xffffffff),
    canvasColor: Color(0xff1F303E),
    focusColor: Color(0xff2D5779),
    useMaterial3: true,
  );
}
