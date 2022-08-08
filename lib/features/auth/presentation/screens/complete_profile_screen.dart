import 'package:flutter/material.dart';

import '../widgets.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: ScreenFit(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: CompleteProfileTitles(),
          ),
          const CompleteProfileForm(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "By continuing, you confirm that you agree \nwith our terms and conditions",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ],
      ),
    );
  }
}
