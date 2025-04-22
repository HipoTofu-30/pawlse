import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pawlse/src/constants/images_text.dart';

Future<void> doggoFur(BuildContext context, String userId) async {
  final doc =
      await FirebaseFirestore.instance.collection("Users").doc(userId).get();
  final currentFur = doc.data()?["dogFurType"] ?? "Not set";

  await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage(ppetNameBackground),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Select Your Pet's Fur Type",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _dogFurButton(context, userId, "Dense"),
                const SizedBox(height: 10),
                _dogFurButton(context, userId, "Thick"),
                const SizedBox(height: 10),
                _dogFurButton(context, userId, "Thin"),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Current: $currentFur",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.brown,
                      ),
                    ),
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
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget _dogFurButton(BuildContext context, String userId, String furType) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(userId)
            .update({"dogFurType": furType});
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.brown[300],
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        furType,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
