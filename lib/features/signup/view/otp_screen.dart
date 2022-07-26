import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';

import '../../../core/router/routes.dart';
import '../../shared/view/widgets.dart';
import 'widgets/otp_input_field.dart';
import 'widgets/otp_titles.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("OTP Verification"),
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
              maxWidth: context.width * (isLandscape ? 0.6 : 0.85),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ),
        ),
      ),
    );
  }

  void gotoHome() {
    Get.offAndToNamed(Routes.home);
  }
}
