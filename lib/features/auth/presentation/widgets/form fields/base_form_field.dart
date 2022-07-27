import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/assets.dart';

class BaseFormField extends StatelessWidget {
  const BaseFormField({
    Key? key,
    this.hint = "",
    required this.label,
    this.iconPath = SvgIcons.user,
    this.inputType = TextInputType.text,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  final String hint;
  final String label;
  final String iconPath;
  final TextInputType inputType;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        errorStyle: const TextStyle(fontSize: 0),
        suffixIconConstraints:
            const BoxConstraints.tightFor(width: 70, height: 20),
        suffixIcon: SvgPicture.asset(iconPath, fit: BoxFit.fitHeight),
      ),
      onSaved: onSaved,
      validator: validator,
      keyboardType: inputType,
    );
  }
}
