import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pawlse/src/constants/images_text.dart';

Future<void> requestPetName(BuildContext context, String userId) async {
  TextEditingController nameController = TextEditingController();
  await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        // Use Dialog instead of AlertDialog for full customization
        backgroundColor: Colors.transparent, // Make background transparent
        child: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image:
                  AssetImage(ppetNameBackground), // Set your background image
              fit: BoxFit.cover, // Cover the entire AlertDialog
            ),
            borderRadius: BorderRadius.circular(15), // Rounded corners
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5), // Padding for better appearance
                decoration: BoxDecoration(
                  color: Colors.brown, // Brown background
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: const Text(
                  "Enter Your Pet's Name",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text for contrast
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Pet Name",
                  filled: true,
                  fillColor: Colors.white.withOpacity(
                      0.8), // Light background for better readability
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
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
                          borderRadius: BorderRadius.circular(
                              8), // Optional: Rounded corners
                        ),
                      ),
                      onPressed: () {
                        String newName = nameController.text.trim();
                        if (newName.isNotEmpty) {
                          FirebaseFirestore.instance
                              .collection("Users")
                              .doc(userId)
                              .update({"petName": newName});
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.black), // Text color
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
