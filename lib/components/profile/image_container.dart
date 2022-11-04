import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({Key? key, required this.imagePath}) : super(key: key);
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imagePath),
        ),
      ),
    );
  }
}
