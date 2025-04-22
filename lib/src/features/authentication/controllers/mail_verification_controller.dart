import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pawlse/src/repository/authentication_repository/authentication_repository.dart';

class MailVerificationController extends GetxController {
  // ignore: unused_field
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    sendEmailVerification();
    setTimerForAutoRedirect();
  }

  Future<void> sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
    } catch (e) {
      Get.snackbar('Oh Snap', e.toString());
    }
  }

  void manuallyCheckEmailVerificationStatus() {
    FirebaseAuth.instance.currentUser?.reload();
    final user = FirebaseAuth.instance.currentUser;
    if (user!.emailVerified) {
      AuthenticationRepository.instance.setInitialScreen(user);
    }
  }

  void setTimerForAutoRedirect() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user!.emailVerified) {
        timer.cancel();
        AuthenticationRepository.instance.setInitialScreen(user);
      }
    });
  }
}
