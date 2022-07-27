import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../widgets/screen_fit_box.dart';
import '../../../../core/router/routes.dart';
import '../widgets.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("OTP Verification"),
    );

    return Scaffold(
      appBar: appBar,
      body: ScreenFitBox(
        appBarHeight: appBar.preferredSize.height,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: OtpTitles(),
          ),
          // TODO: implement form states and submission
          OtpInputField(count: 4),
          ElevatedButton(
            onPressed: gotoHome,
            child: const Text("Continue"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextAction(
              "Resend OTP Code",
              onPressed: () {},
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
