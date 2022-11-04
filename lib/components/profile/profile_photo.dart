import 'package:flutter/material.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({Key? key, this.radius = 30, required this.onTapped})
      : super(key: key);
  static const profilePhotoPath = 'assets/images/me.png';

  final double radius;
  final Function() onTapped;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: radius - 1,
          backgroundImage: const AssetImage(profilePhotoPath),
        ),
      ),
    );
  }
}
