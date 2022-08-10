import 'package:flutter/material.dart';

import '../../../../core/extensions/context.dart';

class TextAction extends StatelessWidget {
  const TextAction(
    this.text, {
    Key? key,
    this.style,
    this.underline = true,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final bool underline;
  final TextStyle? style;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final textStyle = style ?? context.textTheme.subtitle1;

    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: textStyle?.copyWith(
          decoration: underline ? TextDecoration.underline : null,
        ),
      ),
    );
  }
}
