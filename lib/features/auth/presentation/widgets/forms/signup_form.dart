import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/assets/svg_icons.dart';
import '../../../../../app/router/routes.dart';
import '../../../../../core/extensions/context.dart';
import '../../../../../core/utils/validations.dart';
import '../../widgets.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  String? confirmPass;
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
          PasswordFormField(
            hint: "Enter you password",
            validator: (x) {
              confirmPass = x;
              return Validator.validatePass(x);
            },
          ),
          SizedBox(height: 20.h),
          PasswordFormField(
            label: "Confirm Password",
            hint: "Re-enter you password",
            onSaved: (_) {},
            validator: (x) => Validator.validateConfirmPass(x, confirmPass),
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () => register(context),
            child: const Text("Register"),
          ),
        ],
      ),
    );
  }

  void register(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      context.goReplaceAllNamed(Routes.completeProfile);
    }
  }
}
