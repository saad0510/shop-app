import 'package:flutter/material.dart';

class CompleteProfileTitles extends StatelessWidget {
  const CompleteProfileTitles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Complete Profile",
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
