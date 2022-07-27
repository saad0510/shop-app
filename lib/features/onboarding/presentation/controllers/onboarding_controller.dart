import 'package:get/state_manager.dart';

import '../../domain/entities/onboarding_data.dart';
import '../../domain/entities/onboarding_page.dart';

class OnboardingController extends GetxController {
  var activeIndex = 0.obs;

  static const _pages = dataOfOnboardinPages;
  late final count = _pages.length;

  List<OnboardingPage> get pages => _pages;

  bool isValidIndex(int index) => index >= 0 && index < count;

  bool isActiveIndex(int index) => activeIndex.value == index;

  bool get isLastIndex => activeIndex.value == count - 1;

  void moveTo(int newIndex) =>
      isValidIndex(newIndex) ? activeIndex.value = newIndex : '';
}
