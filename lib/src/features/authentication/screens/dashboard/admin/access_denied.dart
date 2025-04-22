import 'package:flutter/material.dart';

Future<dynamic> accessDenied(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Rounded corners
      ),
      title: const Row(
        children: [
          Icon(Icons.warning_amber_rounded,
              color: Colors.red, size: 30), // Warning icon
          SizedBox(width: 10),
          Text(
            "Access Denied",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: const Text(
        "You are not an admin. Please contact support if you need access.",
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Button color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Button roundness
            ),
          ),
          child: const Text("OK", style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}
