import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class FontWeights {
  FontWeights._();

  static const extraLight = FontWeight.w200;
  static const light = FontWeight.w300;
  static const normal = FontWeight.w400;
  static const semibold = FontWeight.w600;
  static const bold = FontWeight.w600;
}

class FontSizes {
  FontSizes._();

  static final headline1 = (30.0.sp);
  static final headline2 = (25.0.sp);
  static final headline3 = (22.0.sp);
  static final headline4 = (19.0.sp);
  static final headline5 = (17.0.sp);
  static final headline6 = (17.0.sp);
  static final body1 = (16.0.sp);
  static final body2 = (15.0.sp);
  static final subtitle1 = (14.0.sp);
  static final subtitle2 = (13.0.sp);
}

class Fonts {
  Fonts._();

  static const family = "Muli";

  static final headline1 = TextStyle(
    fontSize: FontSizes.headline1,
    color: AppColors.primary,
    fontWeight: FontWeights.bold,
  );
  static final headline2 = TextStyle(
    fontSize: FontSizes.headline2,
    color: AppColors.black,
    fontWeight: FontWeights.semibold,
  );
  static final headline3 = TextStyle(
    fontSize: FontSizes.headline3,
    color: AppColors.black,
    fontWeight: FontWeights.semibold,
  );
  static final headline4 = TextStyle(
    fontSize: FontSizes.headline4,
    color: AppColors.black,
    fontWeight: FontWeights.normal,
  );
  static final headline5 = TextStyle(
    fontSize: FontSizes.headline5,
    color: AppColors.black,
    fontWeight: FontWeights.normal,
  );
  static final headline6 = TextStyle(
    fontSize: FontSizes.headline6,
    color: AppColors.text,
    fontWeight: FontWeights.normal,
  );
  static final subtitle1 = TextStyle(
    fontSize: FontSizes.subtitle1,
    color: AppColors.text,
    fontWeight: FontWeights.normal,
  );
  static final subtitle2 = TextStyle(
    fontSize: FontSizes.subtitle2,
    color: AppColors.text,
    fontWeight: FontWeights.normal,
  );
  static final bodyText1 = TextStyle(
    fontSize: FontSizes.body1,
    color: AppColors.text,
    fontWeight: FontWeight.normal,
  );
  static final bodyText2 = TextStyle(
    fontSize: FontSizes.body2,
    color: AppColors.text,
    fontWeight: FontWeights.normal,
  );
}
