import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/assets/svg_icons.dart';
import '../../../../../app/router/routes.dart';
import '../../../../../core/extensions/context.dart';
import '../../../../../core/utils/validations.dart';
import '../../controllers.dart';
import '../../widgets.dart';

class SigninForm extends ConsumerStatefulWidget {
  const SigninForm({Key? key}) : super(key: key);

  @override
  ConsumerState<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends ConsumerState<SigninForm> {
  final formKey = GlobalKey<FormState>();
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    ref.listen<UserState>(userProvider, (_, state) {
      if (state is UserLoaded) {
        context.goReplaceAllNamed(Routes.signinSuccess);
      }
      if (state is UserError) {
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
            onSaved: (v) => email = v!,
            validator: Validator.validateEmail,
          ),
          SizedBox(height: 20.h),
          PasswordFormField(
            hint: "Enter your password",
            onSaved: (v) => password = v!,
            validator: Validator.validatePass,
          ),
          SizedBox(height: 20.h),
          AuthStateButton(
            text: "Sign in",
            onPressed: signin,
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

  Future<void> signin() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await ref.read(userProvider.notifier).signin(email, password);
    }
  }
}
