import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawlse/src/constants/images_text.dart';
import 'package:pawlse/src/features/authentication/screens/dashboard/admin/admin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void adminPassword(BuildContext context) {
  TextEditingController passwordController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent, // Transparent background
        child: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image:
                  AssetImage(ppetNameBackground), // Set your background image
              fit: BoxFit.cover, // Cover the entire dialog
            ),
            borderRadius: BorderRadius.circular(15), // Rounded corners
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.brown, // Brown background
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Enter Admin Password",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text for contrast
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8), // Light background
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.brown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        String enteredPassword = passwordController.text.trim();
                        final prefs = await SharedPreferences.getInstance();
                        String? storedPassword =
                            prefs.getString("adminPassword");

                        if (storedPassword == null) {
                          await prefs.setString(
                              "adminPassword", enteredPassword);
                          storedPassword = enteredPassword;
                        }

                        if (enteredPassword == storedPassword) {
                          Navigator.pop(context);
                          Get.to(() => const AdminScreen());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Incorrect password")),
                          );
                        }
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
