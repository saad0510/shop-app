import 'package:flutter/material.dart';

import '../../../../app/assets/svg_icons.dart';
import 'social_icon.dart';

class SocialActionsBar extends StatelessWidget {
  const SocialActionsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialIcon(
          press: () {},
          asset: SvgIcons.google,
        ),
        const SizedBox(width: 10),
        SocialIcon(
          press: () {},
          asset: SvgIcons.facebook,
        ),
        const SizedBox(width: 10),
        SocialIcon(
          press: () {},
          asset: SvgIcons.twitter,
        ),
      ],
    );
  }
}
