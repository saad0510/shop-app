import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/assets/svg_icons.dart';
import '../../../../../app/router/routes.dart';
import '../../../../../core/extensions/context.dart';
import '../../../../../core/utils/validations.dart';
import '../../controllers.dart';
import '../../widgets.dart';

class CompleteProfileForm extends ConsumerStatefulWidget {
  const CompleteProfileForm({Key? key}) : super(key: key);

  @override
  ConsumerState<CompleteProfileForm> createState() =>
      _CompleteProfileFormState();
}

class _CompleteProfileFormState extends ConsumerState<CompleteProfileForm> {
  late String firstName;
  late String lastName;
  late String phone;
  late String address;
  String? confirmPass;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthUserState>(authUserProvider, (_, state) {
      if (state is AuthUserLoaded) {
        context.goReplaceAllNamed(Routes.home);
      }
      if (state is AuthUserError) {
        context.snackbar(Text(state.message));
      }
    });

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
            onSaved: (val) => firstName = val!,
            validator: Validator.validateName,
          ),
          SizedBox(height: 20.h),
          BaseFormField(
            label: "Last Name",
            hint: "Enter your last name",
            iconPath: SvgIcons.user,
            inputType: TextInputType.name,
            onSaved: (val) => lastName = val!,
          ),
          SizedBox(height: 20.h),
          BaseFormField(
            label: "Phone Number",
            hint: "Enter your phone number",
            iconPath: SvgIcons.phone,
            inputType: TextInputType.number,
            // TODO: input filters
            onSaved: (val) => phone = val!,
            validator: Validator.validatePhone,
          ),
          SizedBox(height: 20.h),
          BaseFormField(
            label: "Address",
            hint: "Enter your address",
            iconPath: SvgIcons.location,
            inputType: TextInputType.text,
            onSaved: (val) => address = val!,
          ),
          SizedBox(height: 20.h),
          AuthStateButton(
            text: "Register",
            onPressed: register,
          ),
        ],
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      ref.read(authUserProvider.notifier).update(
            firstName: firstName,
            lastName: lastName,
            phone: phone,
            address: address,
          );
    }
  }
}
