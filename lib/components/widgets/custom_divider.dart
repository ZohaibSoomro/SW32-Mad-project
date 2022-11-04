import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider(
      {Key? key, this.visibleCircle = false, this.color = Colors.grey})
      : super(key: key);

  final bool visibleCircle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: visibleCircle ? 40 : 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: visibleCircle ? 5 : 0,
          ),
          Expanded(
            child: Divider(
              color: color,
              thickness: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
