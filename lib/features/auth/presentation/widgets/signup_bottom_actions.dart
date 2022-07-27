import 'package:flutter/material.dart';

import '../widgets.dart';

class SignupBottomActions extends StatelessWidget {
  const SignupBottomActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SocialActionsBar(),
        const SizedBox(height: 8),
        Text(
          "By continuing, you confirm that you agree \nwith our terms and conditions",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ],
    );
  }
}
