import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/durations.dart';
import '../../controller/onboarding_controller.dart';

class PageDotBar extends StatelessWidget {
  const PageDotBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        controller.count,
        (i) => Obx(
          () => PageDot(active: controller.isActiveIndex(i)),
        ),
      ),
    );
  }
}

class PageDot extends StatelessWidget {
  const PageDot({Key? key, required this.active}) : super(key: key);

  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Durations.animation,
      height: 10,
      margin: const EdgeInsets.only(right: 8),
      width: active ? 30 : 10,
      decoration: BoxDecoration(
        color: active ? Theme.of(context).colorScheme.primary : Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
