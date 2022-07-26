import 'package:flutter/material.dart';

import 'error_tile.dart';

class ErrorBox extends StatelessWidget {
  const ErrorBox({Key? key, required this.errors}) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    errors.removeWhere((err) => err.isEmpty);
    return errors.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                for (final err in errors) ErrorTile(error: err),
              ],
            ),
          )
        : const SizedBox();
  }
}
