import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constants/durations.dart';
import '../../../core/router/routes.dart';
import '../controller/onboarding_controller.dart';
import 'widgets/onboarding_content.dart';
import 'widgets/page_dot_bar.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();
    final pageController = PageController();
    final isLandscape = context.orientation == Orientation.landscape;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: pageController,
                itemCount: controller.count,
                onPageChanged: (value) => controller.moveTo(value),
                itemBuilder: (_, i) {
                  return OnBoardingContent(page: controller.pages[i]);
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: isLandscape ? 0.5 : 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 3.h),
                    const PageDotBar(),
                    ElevatedButton(
                      onPressed: () {
                        controller.isLastIndex
                            ? Get.offAndToNamed(Routes.signin)
                            : pageController.nextPage(
                                duration: Durations.animation,
                                curve: Curves.easeInOutCirc,
                              );
                      },
                      child: const Text("Continue"),
                    ),
                    SizedBox(height: 3.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}