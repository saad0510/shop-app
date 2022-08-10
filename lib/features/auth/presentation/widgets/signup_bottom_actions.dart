import 'package:flutter/material.dart';

import '../../../../core/extensions/context.dart';
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
          style: context.textTheme.subtitle2,
        ),
      ],
    );
  }
}
