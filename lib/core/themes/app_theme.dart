import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

class AppTheme {
  AppTheme._();

  static final lightTheme = ThemeData(
    // colors
    colorScheme: _colorScheme.copyWith(brightness: Brightness.light),
    scaffoldBackgroundColor: AppColors.background,
    // widgets
    appBarTheme: _appBarTheme,
    iconTheme: _iconTheme,
    elevatedButtonTheme: _elevatedButtonTheme,
    inputDecorationTheme: _inputDecorationTheme,
    checkboxTheme: _checkboxTheme,
    // fonts
    fontFamily: Fonts.family,
    textTheme: _textTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    // colors
    colorScheme: _colorScheme.copyWith(brightness: Brightness.dark),
    scaffoldBackgroundColor: AppColors.background,
    // widgets
    appBarTheme: _appBarTheme,
    iconTheme: _iconTheme,
    elevatedButtonTheme: _elevatedButtonTheme,
    inputDecorationTheme: _inputDecorationTheme,
    checkboxTheme: _checkboxTheme,
    // fonts
    fontFamily: Fonts.family,
    textTheme: _textTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static const _colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    error: AppColors.error,
    onError: AppColors.background,
    background: AppColors.background,
    onBackground: AppColors.onBackground,
    surface: AppColors.onPrimary,
    onSurface: AppColors.background,
  );

  // widgets

  static final _appBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    foregroundColor: AppColors.text,
    backgroundColor: Colors.transparent,
    titleTextStyle: _textTheme.headline6,
  );

  static const _iconTheme = IconThemeData(
    color: AppColors.primary,
  );

  static final _checkboxTheme = CheckboxThemeData(
    visualDensity: VisualDensity.compact,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(3),
    ),
  );

  static final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      textStyle: _textTheme.bodyText1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );

  //  inputs

  static final _inputDecorationTheme = InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.text),
      borderRadius: BorderRadius.circular(100),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
      borderRadius: BorderRadius.circular(100),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.error),
      borderRadius: BorderRadius.circular(100),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.error, width: 2),
      borderRadius: BorderRadius.circular(100),
    ),
    hintStyle: _textTheme.subtitle1,
    labelStyle: _textTheme.headline6,
    errorStyle: _textTheme.subtitle1?.copyWith(color: AppColors.error),
    floatingLabelAlignment: FloatingLabelAlignment.start,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    constraints: BoxConstraints(minHeight: 80.h),
    contentPadding: const EdgeInsets.fromLTRB(30, 15, 0, 15),
  );

  static const otpInputTheme = InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.text),
    ),
    focusedBorder: OutlineInputBorder(),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.error, width: 2),
    ),
    errorStyle: TextStyle(fontSize: 0),
    helperStyle: TextStyle(fontSize: 0),
  );

  // fonts

  static final _textTheme = TextTheme(
    headline1: Fonts.headline1,
    headline2: Fonts.headline2,
    headline3: Fonts.headline3,
    headline4: Fonts.headline4,
    headline5: Fonts.headline5,
    headline6: Fonts.headline6,
    subtitle1: Fonts.subtitle1,
    subtitle2: Fonts.subtitle2,
    bodyText1: Fonts.bodyText1,
    bodyText2: Fonts.bodyText2,
  );
}
