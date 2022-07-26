import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';

import '../../../core/constants/assets.dart';
import '../../../core/router/routes.dart';

class SigninSuccessScreen extends StatelessWidget {
  const SigninSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("Login Success"),
    );
    final bodyHeight =
        context.height - Get.statusBarHeight - appBar.preferredSize.height;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: bodyHeight,
            minWidth: context.width,
          ),
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        ),
      ),
    );
  }

  void gotoHome() {
    Get.offAndToNamed(Routes.home);
  }
}
