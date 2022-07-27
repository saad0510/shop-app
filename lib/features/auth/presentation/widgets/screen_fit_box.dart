import 'package:flutter/material.dart';

import '../../../../core/extensions/context.dart';

class ScreenFitBox extends StatelessWidget {
  const ScreenFitBox({
    Key? key,
    required this.children,
    this.appBarHeight = 0.0,
    this.widthFactor = 0.9,
    this.padding,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
  }) : super(key: key);

  final double appBarHeight;
  final EdgeInsets? padding;
  final double widthFactor;
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final isLandscape = context.orientation == Orientation.landscape;

    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            minHeight: context.height - appBarHeight - context.statusBarHeight,
            maxWidth: context.width * (isLandscape ? 0.6 : widthFactor),
          ),
          padding: padding,
          child: Column(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: children,
          ),
        ),
      ),
    );
  }
}
