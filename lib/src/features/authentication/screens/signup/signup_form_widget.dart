import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawlse/src/constants/colors.dart';
import 'package:pawlse/src/constants/sizes.dart';
import 'package:pawlse/src/constants/text_strings.dart';
import 'package:pawlse/src/features/authentication/controllers/signup_controller.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final formKey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: pFormHeight - 10),
      child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller.fullName,
                decoration: const InputDecoration(
                    label: Text(pFullName),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_outline_rounded,
                        color: pSecondaryColor),
                    labelStyle: TextStyle(color: pSecondaryColor),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.0, color: pSecondaryColor))),
              ),
              const SizedBox(
                height: pFormHeight - 20,
              ),
              TextFormField(
                controller: controller.email,
                decoration: const InputDecoration(
                    label: Text(pEmail),
                    border: OutlineInputBorder(),
                    prefixIcon:
                        Icon(Icons.email_outlined, color: pSecondaryColor),
                    labelStyle: TextStyle(color: pSecondaryColor),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.0, color: pSecondaryColor))),
              ),
              const SizedBox(
                height: pFormHeight - 20,
              ),
              TextFormField(
                controller: controller.phoneNo,
                decoration: const InputDecoration(
                    label: Text(pPhoneNo),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.numbers, color: pSecondaryColor),
                    labelStyle: TextStyle(color: pSecondaryColor),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.0, color: pSecondaryColor))),
              ),
              const SizedBox(
                height: pFormHeight - 20,
              ),
              TextFormField(
                controller: controller.password,
                decoration: const InputDecoration(
                    label: Text(pPassword),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.fingerprint, color: pSecondaryColor),
                    labelStyle: TextStyle(color: pSecondaryColor),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2.0, color: pSecondaryColor))),
              ),
              const SizedBox(
                height: pFormHeight - 10,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        // controller.isLoading.value
                        // ? () {}:
                        () => controller.createUser()
                    // SignupController.instance.phoneAuthentication(
                    //     controller.phoneNo.text.trim());
                    ,
                    child: Text(pSignUp.toUpperCase()),
                  ))
            ],
          )),
    );
  }
}
