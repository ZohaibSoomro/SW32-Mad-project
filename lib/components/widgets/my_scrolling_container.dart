import 'package:flutter/material.dart';
import 'package:sw32_mad_project/styles/text_styles.dart';

class MyScrollingContainer extends StatelessWidget {
  const MyScrollingContainer({
    Key? key,
    required this.child,
    required this.title,
  }) : super(key: key);
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: kLabelTextStyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        primary: true,
        child: child,
      ),
    );
  }
}
