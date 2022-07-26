import 'package:get/get.dart';

import 'features/controllers.dart';

void setupDependencies() {
  // TODO: init and dispose when necessary
  Get.put(OnboardingController());
  Get.put(SigninErrorController());
  Get.put(SignupErrorController());
}
