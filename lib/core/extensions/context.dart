import 'dart:ui' as ui;

import 'package:flutter/material.dart';

extension ContextUtils on BuildContext {
  double get width {
    return MediaQuery.of(this).size.width;
  }

  double get height {
    return MediaQuery.of(this).size.height;
  }

  Orientation get orientation {
    return MediaQuery.of(this).orientation;
  }

  double get statusBarHeight {
    return ui.window.padding.top;
  }

  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }

  void goNamed(String name) async {
    await Navigator.of(this).pushNamed(name);
  }

  void goReplaceNamed(String name) async {
    await Navigator.of(this).pushReplacementNamed(name);
  }

  void goReplaceAllNamed(String name) async {
    while (Navigator.of(this).canPop()) {
      Navigator.of(this).pop();
    }
    await Navigator.of(this).pushReplacementNamed(name);
  }
}
