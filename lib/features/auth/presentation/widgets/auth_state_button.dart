import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context.dart';
import '../controllers.dart';

class AuthStateButton extends StatelessWidget {
  const AuthStateButton({
    required this.onPressed,
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Consumer(
        builder: (_, ref, __) {
          final state = ref.watch(userProvider);
          if (state is UserLoading) {
            return CircularProgressIndicator(
              color: context.colorScheme.background,
            );
          }
          return Text(text);
        },
      ),
    );
  }
}
