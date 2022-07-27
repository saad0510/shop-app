import 'package:flutter/material.dart';

import '../widgets/screen_fit_box.dart';
import '../../../../core/constants/assets.dart';
import '../widgets.dart';

class ForgotPassScreen extends StatelessWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("Forgot Password"),
    );
    return Scaffold(
      appBar: appBar,
      body: ScreenFitBox(
        appBarHeight: appBar.preferredSize.height,
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
    );
  }
}
