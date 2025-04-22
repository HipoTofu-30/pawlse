import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawlse/src/constants/colors.dart';
import 'package:pawlse/src/constants/images_text.dart';
import 'package:pawlse/src/constants/sizes.dart';
import 'package:pawlse/src/constants/text_strings.dart';
import 'package:pawlse/src/features/authentication/screens/login/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(pDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: const AssetImage(pwelcomeIMG),
              height: height * 0.6,
            ),
            const Column(children: [
              Text(pwelcomeTitle),
              Text(
                pwelcomeDesc,
                textAlign: TextAlign.center,
              ),
            ]),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => const LoginScreen());
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          foregroundColor: pWhiteColor,
                          backgroundColor: pSecondaryColor,
                          side: const BorderSide(color: pSecondaryColor),
                          padding: const EdgeInsets.symmetric(
                              vertical: pButtonHeight),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      child: Text("Let's Start".toUpperCase())),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
