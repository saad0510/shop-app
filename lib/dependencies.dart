import 'package:get/get.dart';

import 'features/auth/presentation/controllers.dart';
import 'features/onboarding/presentation/controllers.dart';

void setupDependencies() {
  // TODO: init and dispose when necessary
  Get.put(OnboardingController());
  Get.put(SigninErrorController());
  Get.put(SignupErrorController());
}
