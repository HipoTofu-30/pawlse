import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawlse/src/features/authentication/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection("Users").add(user.toJson());
      Get.snackbar(
        "Success",
        "Your account has been created.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (error) {
      Get.snackbar(
        "Error",
        "Something went wrong, try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print("Error - $error");
    }
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Stream<List<Map<String, dynamic>>> getUsers() {
    return _db
        .collection("Users")
        .where("admin", isEqualTo: false)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => {"id": doc.id, ...doc.data()}).toList());
  }

  Future<List<Map<String, dynamic>>> allUsers() async {
    QuerySnapshot snapshot = await _db.collection("Users").limit(50).get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Stream<List<Map<String, dynamic>>> getAllUsersStream() {
    return _db.collection("Users").snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => {"id": doc.id, ...doc.data()}).toList());
  }
}
