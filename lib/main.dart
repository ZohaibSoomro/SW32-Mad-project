import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sw32_mad_project/screens/about_us_screen.dart';
import 'package:sw32_mad_project/screens/onboarding/on_boarding_is_seen_checker.dart';
import 'package:sw32_mad_project/screens/privacy_policy_screen.dart';

import 'screens/home/home_screen.dart';
import 'screens/onboarding/on_boarding_screen.dart';

int? isOnBoadingScreenSeen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  isOnBoadingScreenSeen = await OnBoardingScreenChecker.getValue;
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routes: {
        '/': (context) => const HomePage(),
        OnBoardingScreen.routeID: (context) => const OnBoardingScreen(),
        HomePage.routeID: (context) => const HomePage(),
        PrivacyPolicyScreen.routeID: (context) => const PrivacyPolicyScreen(),
        AboutUsScreen.routeID: (context) => const AboutUsScreen(),
      },

      ///if isOnBoadingScreenSeen is 1 then that means application on boarding screen is seen one time
      initialRoute: isOnBoadingScreenSeen == 1
          ? HomePage.routeID
          : OnBoardingScreen.routeID,
    );
  }
}
