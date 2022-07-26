import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text("Sign Up"),
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
              maxWidth: context.width * (isLandscape ? 0.6 : 0.9),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          ),
        ),
      ),
    );
  }
}
