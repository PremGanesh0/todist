import 'package:flutter/material.dart';

String BaseUrl = 'https://dev.taskpareto.com/api/';

ColorScheme myColorScheme = const ColorScheme.light(
  primary: Colors.blue,
  secondary: Colors.grey,
  surface: Colors.white,
  background: Colors.white,
  error: Colors.red,
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onSurface: Colors.black,
  onBackground: Colors.black,
  onError: Colors.white,
);

ColorScheme myColorSchemeDark = const ColorScheme.dark(
  primary: Colors.blue,
  secondary: Colors.grey,
  surface: Colors.white,
  background: Colors.white,
  error: Colors.red,
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onSurface: Colors.black,
  onBackground: Colors.black,
  onError: Colors.white,
);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: myColorScheme.primary,
  hintColor: myColorScheme.secondary,
  colorScheme: myColorScheme,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
    displayMedium: TextStyle(fontSize: 18),
    displaySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: myColorSchemeDark.primary,
  hintColor: myColorSchemeDark.secondary,
  colorScheme: myColorSchemeDark,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
    displayMedium: TextStyle(fontSize: 18),
    displaySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
  ),
);
