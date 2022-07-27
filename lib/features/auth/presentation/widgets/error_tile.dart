import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/assets.dart';

class ErrorTile extends StatelessWidget {
  const ErrorTile({Key? key, required this.error}) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(SvgIcons.error, height: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            error,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
        ),
      ],
    );
  }
}
