import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawlse/src/constants/colors.dart';
import 'package:pawlse/src/constants/sizes.dart';
import 'package:pawlse/src/constants/text_strings.dart';
import 'package:pawlse/src/constants/images_text.dart';
import 'package:pawlse/src/features/authentication/controllers/login_controller.dart';
import 'package:pawlse/src/features/authentication/screens/signup/signup_screen.dart';

class LogInFooter extends StatelessWidget {
  const LogInFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  elevation: 0,
                  side: const BorderSide(color: pSecondaryColor),
                  padding: const EdgeInsets.symmetric(vertical: pButtonHeight),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              icon: const Image(
                image: AssetImage(pGoogleLogo),
                width: 20.0,
              ),
              onPressed: () => controller.googleSignIn(),
              label: const Text(
                pSignInWithGoogle,
                style: TextStyle(color: Colors.black),
              )),
        ),
        const SizedBox(
          height: pFormHeight - 20,
        ),
        TextButton(
            onPressed: () {
              Get.to(() => const SignupScreen());
            },
            child: const Text.rich(TextSpan(
                text: pDontHaveAnAccount,
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(text: pSignUp, style: TextStyle(color: Colors.blue))
                ])))
      ],
    );
  }
}
