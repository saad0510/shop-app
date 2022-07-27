import 'package:flutter/material.dart';

class OtpTitles extends StatelessWidget {
  const OtpTitles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "OTP Verification",
          style: Theme.of(context).textTheme.headline2,
        ),
        const SizedBox(height: 8),
        Column(
          children: [
            Text(
              "We sent your code to {user.phone}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "The code will expire in ",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 30, end: 0),
                  duration: const Duration(seconds: 30),
                  onEnd: () {},
                  builder: (_, double val, __) => Text(
                    val.toStringAsFixed(0),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(color: Colors.redAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
