import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';

import '../../../core/constants/assets.dart';
import '../../shared/view/widgets.dart';
import 'widgets/forgot_screen_titles.dart';

class ForgotPassScreen extends StatelessWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("Forgot Password"),
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
                  child: ForgotPasswordTitles(),
                ),
                // TODO: no validation
                const BaseFormField(
                  label: "Email",
                  hint: "Enter your email",
                  iconPath: SvgIcons.email,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Continue"),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: NoAccountAction(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
