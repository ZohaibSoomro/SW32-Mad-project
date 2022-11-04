import 'package:flutter/material.dart';
import 'package:sw32_mad_project/components/widgets/rounded_dialog_container.dart';
import 'package:sw32_mad_project/styles/colors.dart';
import 'package:sw32_mad_project/styles/text_styles.dart';

import 'image_container.dart';
import 'profile_info.dart';
import 'profile_photo.dart';

class ProfileCircleAvatar extends StatelessWidget {
  final ProfileInfo profileInfo = ProfileInfo();

  ProfileCircleAvatar({Key? key, this.radius = 82}) : super(key: key);

  final double radius;

  @override
  Widget build(BuildContext context) {
    return ProfilePhoto(
      radius: radius,
      onTapped: () {
        final profileDialogue = RoundedDialogContainer(
          verticalPadding: 190,
          color: kLightBlue,
          context: context,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Hero(
                tag: 'profile',
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 82,
                  child: ProfilePhoto(
                    radius: 80,
                    onTapped: () {
                      showDialog(
                        context: context,
                        builder: (context) => RoundedDialogContainer(
                          color: kLightBlue,
                          verticalPadding: 100,
                          context: context,
                          child: const ImageContainer(
                            imagePath: ProfilePhoto.profilePhotoPath,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              displayProfileInfoInDpDialog()
            ],
          ),
        );
        showDialog(
          context: context,
          builder: (context) => profileDialogue,
        );
      },
    );
  }

  Widget displayProfileInfoInDpDialog() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        profileInfo.length,
        (index) => Text(
          profileInfo.at(index),
          style: kDpInfoTextStyle,
        ),
      ),
    );
  }
}
