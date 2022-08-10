import 'package:flutter/material.dart';

import '../../../../app/router/routes.dart';
import '../../../../core/extensions/context.dart';
import 'text_action.dart';

class NoAccountAction extends StatelessWidget {
  const NoAccountAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: context.textTheme.subtitle1,
        ),
        TextAction(
          "Sign Up",
          onPressed: () => gotoSignup(context),
          underline: false,
          style: context.textTheme.subtitle1?.copyWith(
            color: context.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  void gotoSignup(BuildContext context) {
    context.goNamed(Routes.signup);
  }
}
