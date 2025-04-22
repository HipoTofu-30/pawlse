import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pawlse/src/constants/sizes.dart';
import 'package:pawlse/src/constants/text_strings.dart';
import 'package:pawlse/src/features/authentication/controllers/mail_verification_controller.dart';
import 'package:pawlse/src/repository/authentication_repository/authentication_repository.dart';

class MailVerification extends StatelessWidget {
  const MailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MailVerificationController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: pDefaultSize * 5,
              left: pDefaultSize,
              right: pDefaultSize,
              bottom: pDefaultSize * 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                LineAwesomeIcons.envelope_open,
                size: 100,
              ),
              const SizedBox(
                height: pDefaultSize * 2,
              ),
              SizedBox(
                  width: 200,
                  child: OutlinedButton(
                    onPressed: () =>
                        controller.manuallyCheckEmailVerificationStatus(),
                    child: Text(pContinue.tr),
                  )),
              const SizedBox(
                height: pDefaultSize * 2,
              ),
              TextButton(
                  onPressed: () => controller.sendEmailVerification(),
                  child: Text(pResendEmailLink.tr)),
              TextButton(
                  onPressed: () => AuthenticationRepository.instance.logOut(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(LineAwesomeIcons.long_arrow_alt_left_solid),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(pBackToLogin.tr.toLowerCase())
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
