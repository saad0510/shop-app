import 'package:flutter/material.dart';

import '../../../../../core/extensions/context.dart';

class ForgotPasswordTitles extends StatelessWidget {
  const ForgotPasswordTitles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Forgot Password",
          textAlign: TextAlign.center,
          style: context.textTheme.headline2,
        ),
        const SizedBox(height: 8),
        Text(
          "Please enter your email and we \nwill send you a link to return to your account",
          textAlign: TextAlign.center,
          style: context.textTheme.subtitle1,
        ),
      ],
    );
  }
}
