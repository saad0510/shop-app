import 'package:flutter/material.dart';

import '../../../../../core/extensions/context.dart';

class SigninTitles extends StatelessWidget {
  const SigninTitles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Welcome Back",
          style: context.textTheme.headline2,
        ),
        const SizedBox(height: 10),
        Text(
          "Sign in with your email and password \nor continue with social media",
          textAlign: TextAlign.center,
          style: context.textTheme.subtitle1,
        ),
      ],
    );
  }
}
