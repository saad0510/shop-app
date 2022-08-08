import 'package:flutter/material.dart';

import '../../../../app/assets/images.dart';
import '../../../../app/router/routes.dart';
import '../../../../core/extensions/context.dart';

class SigninSuccessScreen extends StatelessWidget {
  const SigninSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Success"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                Images.success,
                fit: BoxFit.fitHeight,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Logic Success",
                    textAlign: TextAlign.center,
                    style: context.textTheme.headline2,
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.5,
                    child: ElevatedButton(
                      onPressed: () => gotoHome(context),
                      child: const Text("Back to home"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void gotoHome(BuildContext context) {
    context.goReplaceNamed(Routes.home);
  }
}
