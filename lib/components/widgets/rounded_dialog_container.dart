import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sw32_mad_project/model/custom_padding.dart';
import 'package:sw32_mad_project/styles/custom_styles.dart';

class RoundedDialogContainer extends StatelessWidget {
  final CustomPadding customPadding = CustomPadding();

  RoundedDialogContainer(
      {Key? key,
      required this.context,
      required this.child,
      this.color = kLightPink,
      this.verticalPadding})
      : super(key: key);
  final double? verticalPadding;
  final BuildContext context;
  final Color? color;
  final Widget child;
  final List<Color> randomColors = [
    kLightBlue,
    kLightPink,
    kLightPurple,
    kDeepOrange
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: customPadding.symmetricPadding(50, verticalPadding ?? 160),
      padding: customPadding.symmetricPadding(10, 15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
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
      child: child,
    );
  }
}
