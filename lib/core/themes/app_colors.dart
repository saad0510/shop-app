import 'package:flutter/rendering.dart';

class AppColors {
  AppColors._();

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);

  static const primary = Color(0xFFFF7643);
  static const primaryLight = Color(0xFFE6835F);
  static const onPrimary = white;
  static const secondary = Color(0xFF979797);
  static const onSecondary = white;
  static const background = white;
  static const onBackground = Color(0xFF979797);

  static const text = Color(0xFF757575);
  static const error = Color(0xFFE1291C);

  static const primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
  );
}
