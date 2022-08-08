import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/assets/svg_icons.dart';
import '../../../../../core/utils/validations.dart';
import '../../widgets.dart';

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({Key? key}) : super(key: key);

  @override
  State<ForgotPassForm> createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseFormField(
            label: "Email",
            hint: "Enter your email",
            iconPath: SvgIcons.email,
            inputType: TextInputType.emailAddress,
            onSaved: (_) {},
            validator: Validator.validateEmail,
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () => forgotPass(context),
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }

  void forgotPass(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
  }
}
