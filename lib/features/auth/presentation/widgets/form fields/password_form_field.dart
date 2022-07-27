import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/assets.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    Key? key,
    this.hint = "",
    this.label = "Password",
    this.onSaved,
    this.validator,
  }) : super(key: key);

  final String hint;
  final String label;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool hide = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.label,
        errorStyle: const TextStyle(fontSize: 0),
        suffixIconConstraints: const BoxConstraints.tightFor(
          width: 70,
          height: 25,
        ),
        suffixIcon: GestureDetector(
          onTap: () => setState(() => hide = !hide),
          child: SvgPicture.asset(
            SvgIcons.lock,
            fit: BoxFit.fitHeight,
            color: hide ? null : Colors.black,
          ),
        ),
      ),
      obscureText: hide,
      keyboardType: TextInputType.visiblePassword,
      onSaved: widget.onSaved,
      validator: widget.validator,
    );
  }
}
