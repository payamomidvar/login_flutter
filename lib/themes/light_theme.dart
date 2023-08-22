import 'package:flutter/material.dart';

import '../constants/constants.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: secondaryColor,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: textColor, fontSize: largeFontSize),
    bodyMedium: TextStyle(color: textColor, fontSize: mediumFontSize),
    bodySmall: TextStyle(color: textColor, fontSize: smallFontSize),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primaryColor,

  ),
  inputDecorationTheme: const InputDecorationTheme(
    border:OutlineInputBorder(
      borderSide: BorderSide(width: borderFocusWidth, color: borderColor),
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: borderFocusWidth, color: borderColor),
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    ),
    labelStyle: TextStyle(color: descriptionColor, fontSize: mediumFontSize),
    hintStyle: TextStyle(color: descriptionColor, fontSize: mediumFontSize),
    errorStyle:
        TextStyle(color: textFormFieldErrorColor, fontSize: mediumFontSize),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(width: borderWidth, color: borderErrorColor),
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    ),
    errorMaxLines: 1,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: borderWidth, color: borderColor),
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: textColor,
      backgroundColor: primaryColor,
      textStyle: const TextStyle(fontSize: mediumFontSize),
    ),
  ),
  iconTheme: const IconThemeData(color: iconColor),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.black),
);
