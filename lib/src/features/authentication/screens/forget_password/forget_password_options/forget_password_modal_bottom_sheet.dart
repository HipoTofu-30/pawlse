import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pawlse/src/constants/sizes.dart';
import 'package:pawlse/src/constants/text_strings.dart';
import 'package:pawlse/src/features/authentication/screens/forget_password/forget_password_mail/forget_password_mail.dart';
import 'package:pawlse/src/features/authentication/screens/forget_password/forget_password_options/forget_password_button.dart';

class ForgetPasswordScreen {
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      context: context,
      builder: (context) => Container(
          padding: const EdgeInsets.all(pDefaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pForgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(pForgetPasswordSubTitle,
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(
                height: 30.0,
              ),
              ForgetPasswordButton(
                buttonIcon: Icons.mail_outline_outlined,
                title: pEmail,
                subTitle: pResetViaEMail,
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => const ForgetPasswordMail());
                },
              ),
              const SizedBox(
                height: 20.0,
              ),
              ForgetPasswordButton(
                buttonIcon: Icons.mobile_friendly_rounded,
                title: pPhoneNo,
                subTitle: pResetViaPhone,
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => const ForgetPasswordMail());
                },
              ),
            ],
          )),
    );
  }
}
