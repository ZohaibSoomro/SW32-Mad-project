import 'package:flutter/material.dart';
import 'package:sw32_mad_project/styles/colors.dart';

class CustomBorder {
  OutlineInputBorder buildOutlineInputBorder(
      {double width = 1, Color borderColor = kLightPink}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(width: width, color: borderColor),
    );
  }
}
