import 'package:flutter/material.dart';

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton(
      {super.key,
      required this.buttonIcon,
      required this.subTitle,
      required this.title,
      required this.onTap});

  final IconData buttonIcon;
  final String title, subTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade200),
        child: Row(children: [
          Icon(
            buttonIcon,
            size: 60,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Column(
            children: [
              Text(title, style: Theme.of(context).textTheme.headlineLarge),
              Text(subTitle, style: Theme.of(context).textTheme.bodyLarge),
            ],
          )
        ]),
      ),
    );
  }
}
