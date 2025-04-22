import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pawlse/src/constants/sizes.dart';
import 'package:pawlse/src/constants/text_strings.dart';
import 'package:pawlse/src/features/authentication/controllers/otp_controller.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var otpController = Get.put(OTPController());
    var otp;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(pDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              pOtpTitle,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 80.0,
              ),
            ),
            Text(
              pOtpSubtitle.toUpperCase(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "${pOtpMessage}SampleMail@gmail.com",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            OtpTextField(
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              onSubmit: (code) {
                otp = code;
                OTPController.instance.verifyOTP(otp);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      OTPController.instance.verifyOTP(otp);
                    },
                    child: const Text(pNext)))
          ],
        ),
      ),
    );
  }
}
