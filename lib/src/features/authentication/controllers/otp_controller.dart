import 'package:get/get.dart';
import 'package:pawlse/src/features/authentication/screens/dashboard/user/user_screen.dart';
import 'package:pawlse/src/repository/authentication_repository/authentication_repository.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(() => const UserScreen()) : Get.back();
  }
}
