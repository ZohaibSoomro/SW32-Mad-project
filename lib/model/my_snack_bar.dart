import 'package:flutter/material.dart';
import 'package:sw32_mad_project/styles/colors.dart';
import 'package:sw32_mad_project/styles/text_styles.dart';

import 'custom_border.dart';

class MySnackBar {
  static void show({required BuildContext context, required String text}) {
    SnackBar snackBar = SnackBar(
      content: Text(
        text,
        style: kNormalTextStyle,
      ),
      shape: CustomBorder().buildOutlineInputBorder(borderColor: kLightBlue),
      duration: const Duration(
        seconds: 1,
        milliseconds: 800,
      ),
      backgroundColor: Colors.black54,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
