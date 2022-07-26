import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/app_theme.dart';
import 'opt_digits_field.dart';

class OtpInputField extends StatelessWidget {
  OtpInputField({Key? key, required this.count}) : super(key: key);

  final int count;

  late final List<FocusNode> nodes = List.generate(count, (_) => FocusNode());

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: AppTheme.otpInputTheme,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          count,
          (i) {
            return SizedBox(
              width: 70.sp,
              height: 80.sp,
              child: OtpDigitField(
                focusNode: nodes[i],
                onChanged: (code) {
                  if (i == count - 1) {
                    nodes[i].unfocus();
                  } else {
                    nodes[i + 1].requestFocus();
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
