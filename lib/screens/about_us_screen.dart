import 'package:flutter/material.dart';
import 'package:sw32_mad_project/components/widgets/my_scrolling_container.dart';
import 'package:sw32_mad_project/styles/custom_styles.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);
  static const routeID = 'About Us';
  @override
  Widget build(BuildContext context) {
    return MyScrollingContainer(
      title: 'About Us',
      child: buildAboutUsPageInfo(),
    );
  }

  Widget buildAboutUsPageInfo() => Column(
        children: [
          buildAboutUsPageItem('App Name   ', 'sw32_mad_project'),
          buildAboutUsPageItem('Version      ', '1.0.0'),
          buildAboutUsPageItem('Developer ', 'Pawan Kumar'),
          buildAboutUsPageItem('Contact    ', '19sw32@students.muet.edu.pk',
              mainTextStyle: kLabelTextStyle.copyWith(fontSize: 30)),
          // buildAboutUsPageItem('Profile ', '          👇🏽',
          //     mainTextStyle: kAboutTextStyle.copyWith(fontSize: 25)),
          // ProfileCircleAvatar(
          //   radius: 100,
          // ),
        ],
      );

  Widget buildAboutUsPageItem(String leadingText, String mainText,
      {TextStyle mainTextStyle = kAboutTextStyle}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: [
            Text(
              leadingText,
              style: kTileTextStyle,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                mainText,
                style: mainTextStyle,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
