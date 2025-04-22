import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawlse/src/repository/authentication_repository/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final showPassword = false.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> logInFormKey = GlobalKey<FormState>();

  Future<void> logIn() async {
    try {
      if (!logInFormKey.currentState!.validate()) {
        return;
      }
      final auth = AuthenticationRepository.instance;
      await auth.loginUserWithEmailAndPassword(
          email.text.trim(), password.text.trim());
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      Get.snackbar("Oh Snap", "$e");
    }
  }

  Future<void> googleSignIn() async {
    try {
      final auth = AuthenticationRepository.instance;
      // await auth.signInWithGoogle();
      await auth.handleGoogleSignIn();
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      Get.snackbar("Oh Snap", "$e");
    }
  }
}
