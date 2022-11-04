import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sw32_mad_project/home_page.dart';

class OnBoardingScreen extends StatefulWidget {
  static const id = 'OnBoarding';
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      child: Stack(
        children: [
          SafeArea(
            child: PageView.builder(
              controller: _pageController,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: Lottie.asset(
                      'assets/animations/${selectedIndex + 1}.json',
                      animate: false,
                    ),
                  ),
                );
              },
              onPageChanged: (changedValue) {
                _setSelectedIndex(changedValue);
              },
            ),
          ),
          Positioned(
            right: 15,
            bottom: 30,
            child: FloatingActionButton(
              onPressed: () async {
                _isLastPage()
                    ? {
                        await storeInSharedPreferences(),
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        )
                      }
                    : _navigateToNextPage();
              },
              child:
                  Icon(_isLastPage() ? Icons.check : Icons.arrow_forward_sharp),
            ),
          ),
        ],
      ),
    );
  }

  void _setSelectedIndex(int newValue) {
    setState(() {
      selectedIndex = newValue;
    });
  }

  Future<void> storeInSharedPreferences() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setInt(OnBoardingScreen.id, 1);
  }

  bool _isLastPage() {
    return selectedIndex == 2 ? true : false;
  }

  void _navigateToNextPage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    _setSelectedIndex(_pageController.page!.toInt());
  }
}
