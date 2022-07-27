import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants/assets.dart';
import '../../../../../core/router/routes.dart';
import '../../controllers.dart';
import '../../widgets.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key? key}) : super(key: key);

  @override
  State<CompleteProfileForm> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
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
            label: "First Name",
            hint: "Enter your first name",
            iconPath: SvgIcons.user,
            inputType: TextInputType.name,
            onSaved: (_) {},
            validator: errors.validateName,
          ),
          BaseFormField(
            label: "Last Name",
            hint: "Enter your last name",
            iconPath: SvgIcons.user,
            inputType: TextInputType.name,
            onSaved: (_) {},
          ),
          BaseFormField(
            label: "Phone Number",
            hint: "Enter your phone number",
            iconPath: SvgIcons.phone,
            inputType: TextInputType.number,
            // TODO: input filters
            onSaved: (_) {},
            validator: errors.validatePhone,
          ),
          BaseFormField(
            label: "Address",
            hint: "Enter your address",
            iconPath: SvgIcons.location,
            inputType: TextInputType.text,
            onSaved: (_) {},
          ),
          Obx(
            () => ErrorBox(errors: [errors.name, errors.phone]),
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
      Get.offAndToNamed(Routes.otp);
    }
  }
}
