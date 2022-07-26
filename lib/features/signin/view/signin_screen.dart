import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/signin_bottom_actions.dart';
import 'widgets/signin_form.dart';
import 'widgets/signin_titles.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("Sign In"),
    );
    final bodyHeight =
        context.height - Get.statusBarHeight - appBar.preferredSize.height;
    final isLandscape = context.orientation == Orientation.landscape;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: bodyHeight,
              maxWidth: context.width * (isLandscape ? 0.6 : 0.9),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: SigninTitles(),
                ),
                SigninForm(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: SigninBottomActions(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
