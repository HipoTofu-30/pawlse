import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawlse/src/features/authentication/models/user_model.dart';
import 'package:pawlse/src/repository/authentication_repository/authentication_repository.dart';
import 'package:pawlse/src/repository/user_repository/user_repository.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  final isLoading = false.obs;

  final userRepo = Get.put(UserRepository());

  Future<void> registerUser(String email, String password) async {
    String? error = await AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  void emailAuthentication(String email) {
    AuthenticationRepository.instance.sendEmailVerification();
  }

  Future<void> createUser() async {
    try {
      // isLoading.value = true;
      // if (!signUpFormKey.currentState!.validate()) {
      //   // isLoading.value = false;
      //   return;
      // }
      final user = UserModel(
          fullName: fullName.text.trim(),
          email: email.text.trim(),
          phoneNo: phoneNo.text.trim(),
          password: password.text.trim());

      final auth = AuthenticationRepository.instance;
      await auth.createUserWithEmailAndPassword(user.email, user.password);
      auth.setInitialScreen(auth.firebaseUser);
      UserRepository.instance.createUser(user);
    } catch (e) {
      Get.snackbar("Errorr", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
  }
}
