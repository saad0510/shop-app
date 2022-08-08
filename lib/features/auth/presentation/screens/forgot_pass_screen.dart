import 'package:flutter/material.dart';

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
      body: const ScreenFit(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: ForgotPasswordTitles(),
          ),
          ForgotPassForm(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: NoAccountAction(),
          ),
        ],
      ),
    );
  }
}
