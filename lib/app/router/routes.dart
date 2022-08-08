import 'package:flutter/material.dart';

import '../../core/errors/exception.dart';
import '../../features/auth/presentation/screens.dart';
import '../../features/home/presentation/screens.dart';
import '../../features/onboarding/presentation/screens.dart';

class Routes {
  Routes._();

  static const initial = onboarding;

  static const onboarding = "onboarding";
  static const signin = "signin";
  static const forgotPass = "forgotPass";
  static const signinSuccess = "signinSuccess";
  static const signup = "signup";
  static const completeProfile = "completeProfile";
  static const otp = "otp";
  static const home = "home";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case signin:
        return MaterialPageRoute(
          builder: (_) => const SigninScreen(),
        );
      case forgotPass:
        return MaterialPageRoute(
          builder: (_) => const ForgotPassScreen(),
        );
      case signinSuccess:
        return MaterialPageRoute(
          builder: (_) => const SigninSuccessScreen(),
        );
      case signup:
        return MaterialPageRoute(
          builder: (_) => const SignupScreen(),
        );
      case completeProfile:
        return MaterialPageRoute(
          builder: (_) => const CompleteProfileScreen(),
        );
      case otp:
        return MaterialPageRoute(
          builder: (_) => const OtpScreen(),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      default:
        throw RouteException("route '${settings.name}' not foun");
    }
  }
}
