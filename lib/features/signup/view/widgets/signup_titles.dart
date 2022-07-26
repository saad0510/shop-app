import 'package:flutter/material.dart';

class SignupTitles extends StatelessWidget {
  const SignupTitles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Register Account",
          style: Theme.of(context).textTheme.headline2,
        ),
        const SizedBox(height: 8),
        Text(
          "Complete your details or continue\n with social media",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}
