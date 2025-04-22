import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawlse/src/features/authentication/screens/dashboard/user/profile_menu.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText({
    super.key,
    required this.text,
    required this.style,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style:
            style.copyWith(color: Colors.white), // Keep text color for contrast
      ),
    );
  }
}

AppBar buildCoolAppBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: const GradientText(
      text: 'PAWLSE 🐾', // 🐾 Adds a playful touch
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
      gradient: LinearGradient(
        colors: [Color(0xFFFFA726), Color(0xFF8D6E63)], // 🍂 Orange to Brown
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    centerTitle: true,
    actions: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFFFE0B2), // 🟠 Light warm tone for pets
        ),
        child: IconButton(
          onPressed: () {
            Get.to(() => const ProfileMenu());
          },
          icon: const Icon(Icons.person_2, color: Colors.black),
        ),
      ),
    ],
  );
}
