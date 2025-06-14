import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;
  final Bool? temperature;
  final Bool? heartRate;

  const UserModel({
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.password,
    this.heartRate,
    this.temperature,
    this.id,
  });

  toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        fullName: data["FullName"],
        email: data["Email"],
        phoneNo: data["Phone"],
        password: data["Password"],
        heartRate: data["heartRate"],
        temperature: data["temperature"]);
  }
}
