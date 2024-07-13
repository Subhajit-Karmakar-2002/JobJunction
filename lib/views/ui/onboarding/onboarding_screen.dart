import 'package:flutter/material.dart';
import 'package:jobjunction/controllers/exports.dart';
import 'package:jobjunction/views/common/exports.dart';
import 'package:jobjunction/views/ui/onboarding/widgets/page_one.dart';
import 'package:jobjunction/views/ui/onboarding/widgets/page_three.dart';
import 'package:jobjunction/views/ui/onboarding/widgets/page_two.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();
  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OnBoardNotifier>(
        builder: (context, onBoardNotifier, child) {
          return Stack(
            children: [
              PageView(
                physics: onBoardNotifier.isLastPage
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                onPageChanged: (value) {
                  onBoardNotifier.isLastPage = value == 2;
                },
                controller: pageController,
                children: const [
                  PageOne(),
                  PageTwo(),
                  PageThree(),
                ],
              ),
              onBoardNotifier.isLastPage
                  ? const SizedBox.shrink()
                  : Positioned(
                      bottom: height * 0.04,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: 3,
                          effect: WormEffect(
                              dotColor: Color(kDark.value),
                              activeDotColor: Color(kLight.value),
                              spacing: 12,
                              dotHeight: 2,
                              dotWidth: 20),
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
