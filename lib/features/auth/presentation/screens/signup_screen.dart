import 'package:flutter/material.dart';

import '../widgets.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: const ScreenFit(
        children: [
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
