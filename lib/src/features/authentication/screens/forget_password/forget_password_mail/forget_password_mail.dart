import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pawlse/src/common_widget/form/form_header_widget.dart';
import 'package:pawlse/src/constants/images_text.dart';
import 'package:pawlse/src/constants/sizes.dart';
import 'package:pawlse/src/constants/text_strings.dart';
import 'package:pawlse/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';

class ForgetPasswordMail extends StatelessWidget {
  const ForgetPasswordMail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(pDefaultSize),
          child: Column(
            children: [
              const SizedBox(
                height: pDefaultSize * 4,
              ),
              const FormHeaderWidget(
                image: pTest,
                subTitle: pForgetPasswordSubTitle,
                title: pForgetPasswordTitle,
                crossAxisAlignment: CrossAxisAlignment.center,
                heightBetween: 30.0,
                textAlign: TextAlign.center,
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text(pEmail),
                        hintText: pEmail,
                        prefixIcon: Icon(Icons.mail_outline_outlined)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.to(() => const OTPScreen());
                          },
                          child: const Text(pNext)))
                ],
              ))
            ],
          ),
        ),
      )),
    );
  }
}
