import 'package:flutter/material.dart';
import 'package:sw32_mad_project/components/widgets/rounded_container.dart';
import 'package:sw32_mad_project/styles/custom_styles.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    this.child,
    required this.onPressed,
    this.onLongPress,
    this.color,
    this.padding,
    this.marginValue,
    this.paddingValue,
    this.borderRadius,
    this.buttonText = '',
  }) : super(key: key);
  final Widget? child;
  final String buttonText;
  final EdgeInsetsGeometry? padding;
  final double? marginValue;
  final double? paddingValue;
  final Function() onPressed;
  final Function()? onLongPress;
  final Color? color;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      onLongPress: onLongPress,
      child: RoundedContainer(
        paddingValue: paddingValue ?? 15,
        margin: marginValue ?? 10,
        child: buttonText == ''
            ? child!
            : Container(
                padding: padding,
                child: Text(
                  buttonText,
                  style: kTileTextStyle,
                ),
              ),
        color: color,
        borderRadius: borderRadius ?? RoundedContainer.defaultBorderRadius,
      ),
    );
  }
}
