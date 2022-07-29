import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/assets/svg_icons.dart';
import '../../../../../app/router/routes.dart';
import '../../controllers.dart';
import '../../widgets.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  String? confirmPass;
  final formKey = GlobalKey<FormState>();
  final errors = Get.find<SignupErrorController>();

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
            hint: "Enter you password",
            validator: (x) {
              confirmPass = x;
              return errors.validatePass(x);
            },
          ),
          PasswordFormField(
            label: "Confirm Password",
            hint: "Re-enter you password",
            onSaved: (_) {},
            validator: (x) {
              return errors.validateConfirmPass(x, confirmPass);
            },
          ),
          Obx(
            () => ErrorBox(errors: [
              errors.passErr,
              errors.emailErr,
              errors.confirmPassErr,
            ]),
          ),
          ElevatedButton(
            onPressed: register,
            child: const Text("Register"),
          ),
        ],
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      Get.offAllNamed(Routes.completeProfile);
    }
  }
}
