import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/assets/svg_icons.dart';
import '../../../../../app/router/routes.dart';
import '../../../../../core/extensions/context.dart';
import '../../../../../core/utils/validations.dart';
import '../../widgets.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({Key? key}) : super(key: key);

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
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
            hint: "Enter your password",
            onSaved: (_) {},
            validator: Validator.validatePass,
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () => signin(context),
            child: const Text("Continue"),
          ),
          SizedBox(height: 10.h),
          TextAction(
            "Forgot Password",
            onPressed: () => gotoForgotPass(context),
          )
        ],
      ),
    );
  }

  void gotoForgotPass(BuildContext context) {
    context.goNamed(Routes.forgotPass);
  }

  void signin(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      context.goReplaceNamed(Routes.signinSuccess);
    }
  }
}
