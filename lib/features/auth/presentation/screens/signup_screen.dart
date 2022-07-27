import 'package:flutter/material.dart';

import '../widgets/screen_fit_box.dart';
import '../widgets.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("Sign Up"),
    );
    return Scaffold(
      appBar: appBar,
      body: ScreenFitBox(
        appBarHeight: appBar.preferredSize.height,
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: SignupTitles(),
          ),
          SignupForm(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: SignupBottomActions(),
          ),
        ],
      ),
    );
  }
}
