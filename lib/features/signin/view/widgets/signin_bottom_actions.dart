import 'package:flutter/material.dart';

import '../../../shared/view/widgets.dart';

class SigninBottomActions extends StatelessWidget {
  const SigninBottomActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SocialActionsBar(),
        SizedBox(height: 10),
        NoAccountAction(),
      ],
    );
  }
}
