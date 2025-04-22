import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget(
      {super.key,
      required this.image,
      required this.subTitle,
      required this.title,
      this.imageColor,
      this.imageHeight = 0.2,
      this.heightBetween,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.textAlign});

  final Color? imageColor;
  final double imageHeight;
  final double? heightBetween;
  final String image, title, subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(image: AssetImage(image), height: size.height * 0.2),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(subTitle,
            textAlign: textAlign, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
