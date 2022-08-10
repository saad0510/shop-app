import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/constants/durations.dart';
import '../../../../app/router/routes.dart';
import '../../../../core/extensions/context.dart';
import '../../domain/entities/onboarding_data.dart';
import '../widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pages = dataOfOnboardinPages;
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final isLandscape = context.orientation == Orientation.landscape;

    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: isLandscape ? 0.6 : 0.9,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) => setState(() => activeIndex = index),
                  itemBuilder: (_, i) => OnBoardingContent(page: pages[i]),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PageDotBar(
                      activeIndex: activeIndex,
                      count: pages.length,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        activeIndex == pages.length - 1
                            ? context.goReplaceNamed(Routes.signin)
                            : pageController.nextPage(
                                duration: Durations.animation,
                                curve: Curves.easeInOutCirc,
                              );
                      },
                      child: const Text("Continue"),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
