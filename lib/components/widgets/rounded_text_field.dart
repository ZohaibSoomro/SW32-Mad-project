import 'package:flutter/material.dart';
import 'package:sw32_mad_project/model/custom_border.dart';
import 'package:sw32_mad_project/styles/custom_styles.dart';

class RoundedTextField extends StatelessWidget {
  RoundedTextField({
    Key? key,
    required this.onChanged,
    this.label = 'Title',
    this.suffixText,
    this.textController,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  final Function(String)? onChanged;
  final String label;
  final TextEditingController? textController;
  final String? suffixText;
  final TextInputType? keyboardType;
  final CustomBorder customBorder = CustomBorder();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        controller: textController,
        style: kTextFieldTextStyle,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          suffixText: suffixText,
          labelStyle: kNormalTextStyle.copyWith(
            color: Colors.white.withOpacity(0.5),
          ),
          enabledBorder: customBorder.buildOutlineInputBorder(),
          focusedBorder: customBorder.buildOutlineInputBorder(width: 1.8),
          icon: Icon(
            Icons.text_fields,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}
