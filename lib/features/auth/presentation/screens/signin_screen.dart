import 'package:flutter/material.dart';

import '../widgets.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: const ScreenFit(
        children: [
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
