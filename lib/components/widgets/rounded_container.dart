import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sw32_mad_project/styles/colors.dart';

class RoundedContainer extends StatelessWidget {
  RoundedContainer(
      {Key? key,
      required this.child,
      this.color,
      this.borderRadius = defaultBorderRadius,
      this.margin = 10,
      this.paddingValue = 15,
      this.isBorderRadiusForAll = true})
      : super(key: key);
  final Widget child;
  final Color? color;
  final double borderRadius;
  final bool isBorderRadiusForAll;
  final double margin;
  final double paddingValue;
  static const double defaultBorderRadius = 12.0;
  final List<Color> randomColors = [
    kLightBlue,
    kLightPink,
    kLightPurple,
    kDeepOrange
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.symmetric(
          horizontal: paddingValue, vertical: borderRadius / 2 + 6),
      child: child,
      decoration: BoxDecoration(
        borderRadius: isBorderRadiusForAll
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              ),
        color: color ?? kDeepOrange,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            randomColors[Random().nextInt(randomColors.length)],
            color?.withOpacity(0.6) ?? kDeepOrange.withOpacity(0.6),
            color ?? kDeepOrange,
          ],
        ),
      ),
    );
  }
}
