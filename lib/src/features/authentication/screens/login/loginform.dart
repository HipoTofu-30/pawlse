import 'package:flutter/material.dart';
import 'package:pawlse/src/constants/sizes.dart';
import 'package:pawlse/src/constants/text_strings.dart';
import 'package:pawlse/src/features/authentication/screens/forget_password/forget_password_options/forget_password_modal_bottom_sheet.dart';
import 'package:pawlse/src/repository/authentication_repository/authentication_repository.dart';

class LogInForm extends StatelessWidget {
  LogInForm({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: pEmail,
                hintText: pEmail,
                border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: pFormHeight - 20,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.fingerprint_outlined),
                labelText: pPassword,
                hintText: pPassword,
                border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: pFormHeight - 20,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {
                  ForgetPasswordScreen.buildShowModalBottomSheet(context);
                },
                child: const Text(pForgetPassword)),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  AuthenticationRepository().loginUserWithEmailAndPassword(
                      _emailController.text, _passwordController.text);
                },
                child: Text(pLogIn.toUpperCase())),
          )
        ],
      ),
    ));
  }
}
