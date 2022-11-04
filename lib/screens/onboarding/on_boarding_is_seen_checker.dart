import "package:shared_preferences/shared_preferences.dart";

import 'on_boarding_screen.dart';

class OnBoardingScreenChecker {
  static Future<void> setValue(int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(OnBoardingScreen.onBoardingScreenSeen, value);
  }

  static Future<int?> get getValue async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? isOnBoardingSeen =
        preferences.getInt(OnBoardingScreen.onBoardingScreenSeen);
    return isOnBoardingSeen;
  }
}
