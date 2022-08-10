import 'package:flutter/material.dart';

import '../../../../../core/extensions/context.dart';

class SignupTitles extends StatelessWidget {
  const SignupTitles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Register Account",
          style: context.textTheme.headline2,
        ),
        const SizedBox(height: 8),
        Text(
          "Complete your details or continue\n with social media",
          textAlign: TextAlign.center,
          style: context.textTheme.subtitle1,
        ),
      ],
    );
  }
}
