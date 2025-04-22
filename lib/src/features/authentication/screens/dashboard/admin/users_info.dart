import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pawlse/src/constants/images_text.dart';
import 'package:pawlse/src/features/authentication/screens/message/message_screen.dart';

class UserInfoContainer extends StatelessWidget {
  final String userId;
  final String name;
  final String email;
  final String phone;
  final String petName;
  final String photoURL;
  final bool accessToDisplay;
  final bool admin;

  const UserInfoContainer({
    Key? key,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.accessToDisplay,
    required this.petName,
    required this.photoURL,
    required this.admin,
  }) : super(key: key);

  void updateUserField(String field) async {
    DocumentReference userDoc =
        FirebaseFirestore.instance.collection("Users").doc(userId);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(userDoc);
      if (snapshot.exists) {
        bool currentValue = snapshot.get(field);
        transaction.update(userDoc, {field: !currentValue});
      }
    }).then((_) {
      print("$field toggled successfully ✅");
    }).catchError((error) {
      print("Error toggling $field: $error ❌");
    });
  }

  void deleteUserAccount(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          content: const Text(
              "You want to delete this account? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(userId)
                      .delete();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Account deleted successfully ✅")),
                  );
                } catch (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error deleting account: $error ❌")),
                  );
                }
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
        image: const DecorationImage(
          image: AssetImage(ppetNameBackground),
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.grey,
                backgroundImage:
                    photoURL.isNotEmpty ? NetworkImage(photoURL) : null,
                child: photoURL.isEmpty
                    ? const Icon(Icons.person, color: Colors.white, size: 28)
                    : null,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    phone,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(thickness: 1.2, height: 20, color: Colors.grey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Pet's Name", style: TextStyle(fontSize: 16)),
              Text(
                petName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.monitor_heart, color: Colors.black, size: 22),
                  SizedBox(width: 6),
                  Text(
                    "Temp and BPM Monitor",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Switch(
                value: accessToDisplay,
                onChanged: (value) {
                  updateUserField("accessToDisplay");
                },
                activeColor: Colors.brown,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.to(() => MessageScreen(
                          receiverUserEmail: email,
                          receiverUserId: userId,
                        ));
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.comment,
                            color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Text(
                          "Message",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: () => deleteUserAccount(context),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.delete, color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Text(
                          "Delete",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
