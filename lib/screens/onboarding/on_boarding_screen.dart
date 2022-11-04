import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sw32_mad_project/components/widgets/rounded_button.dart';
import 'package:sw32_mad_project/screens/home/home_screen.dart';
import 'package:sw32_mad_project/screens/onboarding/on_boarding_is_seen_checker.dart';
import 'package:sw32_mad_project/styles/colors.dart';
import 'package:sw32_mad_project/styles/text_styles.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  static get onBoardingScreenSeen => 'ON_BOARDING_SCREEN_SEEN';
  static const String routeID = 'on_boarding';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _pageController = PageController(initialPage: 0);
  int currentPageIndex = 0;
  final _pages = [
    Lottie.asset(
      'assets/animations/manage-tasks.json',
    ),
    Lottie.asset(
      'assets/animations/task-ontime.json',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          controller: _pageController,
          itemCount: _pages.length,
          onPageChanged: (value) {
            setState(() {
              currentPageIndex = value;
            });
          },
          itemBuilder: (context, pageIndex) {
            return SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                    width: double.infinity,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: RoundedButton(
                      child: const Text('Skip'),
                      onPressed: () {
                        setOnBoardingScreenSeen();
                        navigateToHomePage(context);
                      },
                    ),
                  ),
                  const Text(
                    'sw32_mad_project',
                    style: kTitleTextStyle,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(child: _pages[currentPageIndex]),
                        Text(
                          pageIndex == 0
                              ? 'Manage Your Tasks'
                              : 'Mark your tasks done ✔',
                          textAlign: TextAlign.center,
                          style: kLabelTextStyle,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      _pages.length,
                      (index) => buildPageDot(pageIndex: index),
                    ),
                  ),
                  RoundedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(isLastPage(pageIndex) ? 'Continue' : 'Next'),
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          isLastPage(pageIndex)
                              ? Icons.check
                              : Icons.arrow_forward,
                          color: Colors.white,
                          size: 18,
                        )
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        if (isLastPage(pageIndex)) {
                          setOnBoardingScreenSeen();
                          navigateToHomePage(context);
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(
                              milliseconds: 300,
                            ),
                            curve: Curves.easeIn,
                          );
                        }
                        currentPageIndex = pageIndex;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                ],
              ),
            );
          }),
    );
  }

  void navigateToHomePage(BuildContext context) {
    Navigator.pushReplacementNamed(context, HomePage.routeID);
  }

  Container buildPageDot({int? pageIndex}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: isCurrentPage(pageIndex) ? 20 : 12,
      height: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: isCurrentPage(pageIndex)
            ? kDeepOrange
            : kDeepOrange.withOpacity(0.4),
      ),
    );
  }

  bool isLastPage(int? pageIndex) {
    return pageIndex == _pages.length - 1;
  }

  bool isCurrentPage(int? pageIndex) {
    return pageIndex == currentPageIndex;
  }

  void setOnBoardingScreenSeen() async {
    await OnBoardingScreenChecker.setValue(1);
  }
}
