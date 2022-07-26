import 'package:flutter/material.dart';

import '../../models/onboarding_page.dart';

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({Key? key, required this.page}) : super(key: key);

  final OnboardingPage page;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          page.title,
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: 8),
        Text(
          page.description,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Expanded(
          flex: 5,
          child: Image.asset(
            page.image,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
