import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/router/routes.dart';
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
          style: Theme.of(context).textTheme.subtitle1,
        ),
        TextAction(
          "Sign Up",
          onPressed: gotoSignup,
          underline: false,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ],
    );
  }

  void gotoSignup() {
    Get.toNamed(Routes.signup);
  }
}
