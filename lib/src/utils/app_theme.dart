import 'package:flutter/material.dart';

const ColorScheme colorScheme = ColorScheme(
  primary: Colors.white,
  primaryContainer: Color(0xff239DD1),
  surface: Color(0xff2E2739),
  background: Colors.grey,
  secondary: Color(0xff2E2739),
  secondaryContainer: Color(0xff606260),
  error: Colors.redAccent,
  onPrimary: Color(0xFFFFFFFF),
  onSecondary: Color(0xff239DD1),
  onSurface: Colors.white,
  onBackground: Color(0xff606260),
  onError: Colors.redAccent,
  brightness: Brightness.dark,
);

final ThemeData theme = ThemeData(
  fontFamily: 'PoetsenOne',
  useMaterial3: true,
  colorScheme: colorScheme,
);

TextStyle asapRegular({
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.normal,
  String fontFamily = 'Asap',
}) {
  return TextStyle(
    color: Colors.white,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: fontFamily,
  );
}

TextStyle svnRegular({
  double fontSize = 16,
  FontWeight fontWeight = FontWeight.normal,
  String fontFamily = 'SVN',
}) {
  return TextStyle(
    color: Colors.white,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: fontFamily,
  );
}
