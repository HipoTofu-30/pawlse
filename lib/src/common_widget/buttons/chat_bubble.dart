import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String formattedTime;
  final CrossAxisAlignment crossAxisAlignment;
  final Color color;
  final Color textColor;

  const ChatBubble(
      {super.key,
      required this.message,
      required this.color,
      required this.textColor,
      required this.formattedTime,
      required this.crossAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Text(
              message,
              style: TextStyle(color: textColor),
            ),
            Text(
              formattedTime,
              style: TextStyle(color: textColor, fontSize: 10),
            ),
          ],
        ));
  }
}
