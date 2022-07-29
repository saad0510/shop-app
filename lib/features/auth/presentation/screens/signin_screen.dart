import 'package:flutter/material.dart';

import '../widgets.dart';
import '../widgets/screen_fit_box.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("Sign In"),
    );
    return Scaffold(
      appBar: appBar,
      body: ScreenFitBox(
        appBarHeight: appBar.preferredSize.height,
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
    );
  }
}
