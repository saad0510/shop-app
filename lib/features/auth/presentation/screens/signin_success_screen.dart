import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../widgets/screen_fit_box.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/router/routes.dart';

class SigninSuccessScreen extends StatelessWidget {
  const SigninSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("Login Success"),
    );
    return Scaffold(
      appBar: appBar,
      body: ScreenFitBox(
        widthFactor: 1,
        appBarHeight: appBar.preferredSize.height,
        padding: const EdgeInsets.symmetric(vertical: 30),
        children: [
          Image.asset(
            Images.success,
            width: 500,
            fit: BoxFit.fitWidth,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Text(
              "Logic Success",
              textAlign: TextAlign.center,
              style: Get.textTheme.headline2,
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.5,
            child: ElevatedButton(
              onPressed: gotoHome,
              child: const Text("Back to home"),
            ),
          ),
        ],
      ),
    );
  }

  void gotoHome() {
    Get.offAndToNamed(Routes.home);
  }
}
