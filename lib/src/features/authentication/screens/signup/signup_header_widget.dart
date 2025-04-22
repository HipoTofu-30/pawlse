import 'package:flutter/material.dart';
import 'package:pawlse/src/constants/images_text.dart';
import 'package:pawlse/src/constants/text_strings.dart';

class SignUpHeaderWidget extends StatelessWidget {
  const SignUpHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: const AssetImage(
            pwelcomeIMG,
          ),
          height: size.height * 0.2,
        ),
        Text(
          pLoginTitle,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          pLoginSubTitle,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
