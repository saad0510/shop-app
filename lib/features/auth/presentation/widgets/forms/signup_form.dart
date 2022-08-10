import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/assets/svg_icons.dart';
import '../../../../../app/router/routes.dart';
import '../../../../../core/extensions/context.dart';
import '../../../../../core/utils/validations.dart';
import '../../../domain/entities/user_data.dart';
import '../../controllers.dart';
import '../../widgets.dart';

class SignupForm extends ConsumerStatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends ConsumerState<SignupForm> {
  String? confirmPass;
  late String email;
  late String password;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthUserState>(authUserProvider, (_, state) {
      if (state is AuthUserLoaded) {
        context.goReplaceAllNamed(Routes.completeProfile);
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
            label: "Email",
            hint: "Enter your email",
            iconPath: SvgIcons.email,
            inputType: TextInputType.emailAddress,
            onSaved: (val) => email = val!,
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
            onSaved: (val) => password = val!,
            validator: (x) => Validator.validateConfirmPass(x, confirmPass),
          ),
          SizedBox(height: 20.h),
          AuthStateButton(
            text: "Sign up",
            onPressed: register,
          ),
        ],
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      ref.read(authUserProvider.notifier).signup(
            UserData.only(email: email, password: password),
          );
    }
  }
}
