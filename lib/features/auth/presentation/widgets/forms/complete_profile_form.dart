import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/assets/svg_icons.dart';
import '../../../../../app/router/routes.dart';
import '../../../../../core/extensions/context.dart';
import '../../../../../core/utils/validations.dart';
import '../../widgets.dart';

class CompleteProfileForm extends StatefulWidget {
  const CompleteProfileForm({Key? key}) : super(key: key);

  @override
  State<CompleteProfileForm> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
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
            label: "First Name",
            hint: "Enter your first name",
            iconPath: SvgIcons.user,
            inputType: TextInputType.name,
            onSaved: (_) {},
            validator: Validator.validateName,
          ),
          SizedBox(height: 20.h),
          BaseFormField(
            label: "Last Name",
            hint: "Enter your last name",
            iconPath: SvgIcons.user,
            inputType: TextInputType.name,
            onSaved: (_) {},
          ),
          SizedBox(height: 20.h),
          BaseFormField(
            label: "Phone Number",
            hint: "Enter your phone number",
            iconPath: SvgIcons.phone,
            inputType: TextInputType.number,
            // TODO: input filters
            onSaved: (_) {},
            validator: Validator.validatePhone,
          ),
          SizedBox(height: 20.h),
          BaseFormField(
            label: "Address",
            hint: "Enter your address",
            iconPath: SvgIcons.location,
            inputType: TextInputType.text,
            onSaved: (_) {},
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
      context.goReplaceNamed(Routes.otp);
    }
  }
}
