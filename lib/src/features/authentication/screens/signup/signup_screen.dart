import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawlse/src/common_widget/form/form_header_widget.dart';
import 'package:pawlse/src/constants/images_text.dart';
import 'package:pawlse/src/constants/sizes.dart';
import 'package:pawlse/src/constants/text_strings.dart';
import 'package:pawlse/src/features/authentication/controllers/login_controller.dart';
import 'package:pawlse/src/features/authentication/screens/signup/signup_form_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(pDefaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FormHeaderWidget(
                  image: pwelcomeIMG,
                  subTitle: pSignUpSubTitle,
                  title: pSignUpTitle),
              const SignUpFormWidget(),
              Column(
                children: [
                  const Text("OR"),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => controller.googleSignIn(),
                      icon: const Image(
                        image: AssetImage(pGoogleLogo),
                        width: 20.0,
                      ),
                      label: Text(pSignInWithGoogle.toUpperCase()),
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: pAlreadyHaveAnAccount,
                            style: Theme.of(context).textTheme.bodyLarge),
                        TextSpan(text: pLogIn.toUpperCase())
                      ])))
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
