import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpDigitField extends StatelessWidget {
  const OtpDigitField({
    Key? key,
    required this.focusNode,
    required this.onChanged,
  }) : super(key: key);

  final FocusNode focusNode;
  final void Function(String code) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: TextFormField(
        maxLength: 1,
        obscureText: true,
        autofocus: true,
        focusNode: focusNode,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1,
        keyboardType: TextInputType.number,
        validator: (x) => x?.length != 1 ? "" : null,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
