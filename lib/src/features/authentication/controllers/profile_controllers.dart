import 'package:get/get.dart';
import 'package:pawlse/src/repository/authentication_repository/authentication_repository.dart';
import 'package:pawlse/src/repository/user_repository/user_repository.dart';

class ProfileControllers extends GetxController {
  static ProfileControllers get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData() {
    final email = _authRepo.firebaseUser?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  Future<List<Map<String, dynamic>>> getAllUser() async {
    return await _userRepo.allUsers();
  }
}
