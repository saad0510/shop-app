import 'package:flutter/material.dart';

import '../../../../core/extensions/context.dart';

class ScreenFit extends StatelessWidget {
  const ScreenFit({
    Key? key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
  }) : super(key: key);

  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    bool isLandscape = context.orientation == Orientation.landscape;

    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: context.width * (isLandscape ? 0.6 : 0.9),
              ),
              child: Column(
                mainAxisAlignment: mainAxisAlignment,
                crossAxisAlignment: crossAxisAlignment,
                children: children,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
