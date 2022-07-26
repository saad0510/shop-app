import 'package:get/get_navigation/get_navigation.dart';

import '../../features/home/view/home_screen.dart';
import '../../features/screens.dart';
import '../../features/signup/view/complete_profile_screen.dart';
import '../../features/signup/view/otp_screen.dart';
import '../../features/signup/view/signup_screen.dart';

class Routes {
  Routes._();

  static const initial = onboarding;

  static const onboarding = "/onboarding";
  static const signin = "/signin";
  static const forgotPass = "/forgotPass";
  static const signinSuccess = "/signinSuccess";
  static const signup = "/signup";
  static const completeProfile = "/completeProfile";
  static const otp = "/otp";
  static const home = "/home";

  static final getPages = [
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: signin, page: () => const SigninScreen()),
    GetPage(name: forgotPass, page: () => const ForgotPassScreen()),
    GetPage(name: signinSuccess, page: () => const SigninSuccessScreen()),
    GetPage(name: signup, page: () => const SignupScreen()),
    GetPage(name: completeProfile, page: () => const CompleteProfileScreen()),
    GetPage(name: otp, page: () => const OtpScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
  ];
}
