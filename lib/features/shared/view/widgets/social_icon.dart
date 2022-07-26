import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialIcon extends StatelessWidget {
  const SocialIcon({
    Key? key,
    required this.asset,
    required this.press,
  }) : super(key: key);

  final String asset;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      customBorder: const CircleBorder(),
      splashFactory: InkRipple.splashFactory,
      highlightColor: Colors.blue.withOpacity(0.3),
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.blue.withOpacity(0.1),
        child: SvgPicture.asset(asset, height: 18),
      ),
    );
  }
}
