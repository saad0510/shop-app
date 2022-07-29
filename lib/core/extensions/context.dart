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
}
