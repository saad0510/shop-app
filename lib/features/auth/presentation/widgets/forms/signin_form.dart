import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/assets.dart';
import '../../../../../core/router/routes.dart';
import '../../controllers.dart';
import '../../widgets.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({Key? key}) : super(key: key);

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final formKey = GlobalKey<FormState>();
  final errors = Get.find<SigninErrorController>();

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
            validator: errors.validateEmail,
          ),
          PasswordFormField(
            hint: "Enter your password",
            onSaved: (_) {},
            validator: errors.validatePass,
          ),
          Obx(
            () => ErrorBox(errors: [errors.emailErr, errors.passErr]),
          ),
          ElevatedButton(
            onPressed: signin,
            child: const Text("Continue"),
          ),
          const SizedBox(height: 10),
          TextAction(
            "Forgot Password",
            onPressed: gotoForgotPass,
          )
        ],
      ),
    );
  }

  void gotoForgotPass() {
    Get.toNamed(Routes.forgotPass);
  }

  void signin() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Get.offAndToNamed(Routes.signinSuccess);
    }
  }
}
