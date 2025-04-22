import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pawlse/src/constants/sizes.dart';
import 'package:pawlse/src/constants/text_strings.dart';
import 'package:pawlse/src/features/authentication/screens/dashboard/admin/access_denied.dart';
import 'package:pawlse/src/features/authentication/screens/dashboard/admin/admin_password.dart';
import 'package:pawlse/src/features/authentication/screens/dashboard/user/doggo_fur.dart';
import 'package:pawlse/src/features/authentication/screens/dashboard/user/request_pet_name.dart';
import 'package:pawlse/src/features/authentication/screens/dashboard/user/widgets.dart';
import 'package:pawlse/src/features/authentication/screens/login/login_screen.dart';
import 'package:pawlse/src/repository/authentication_repository/authentication_repository.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  Future<void> showAdminDialog(BuildContext context, String userId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>?;
        bool userIsAdmin = data?['admin'] ?? false;

        if (!userIsAdmin) {
          accessDenied(context);
        } else {
          adminPassword(context);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error, try again")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String? userId = AuthenticationRepository().getCurrentUserId();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          pProfileTitle,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left_solid),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => const LoginScreen());
                    },
                    child: const Text("Back to Log In")));
          }

          var data = snapshot.data!.data() as Map<String, dynamic>?;
          String? profileImage = data?['photoURL'];
          String userName = data?['name'] ?? "User";
          String petName = data?['petName'] ?? "No Pet";

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(pDefaultSize),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Stack(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: profileImage != null && profileImage.isNotEmpty
                              ? Image.network(
                                  profileImage,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.person, size: 120),
                                )
                              : const Icon(Icons.person, size: 120),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(userName,
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 5),
                  Text("Your Pet's Name: $petName",
                      style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        requestPetName(context, userId!);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        side: BorderSide.none,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text(
                        pEditProfile,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Divider(),
                  const SizedBox(height: 10),
                  ProfileWidget(
                    title: pMenu1,
                    icon: LineAwesomeIcons.feather_alt_solid,
                    onTap: () {
                      doggoFur(context, userId!);
                    },
                    endIcon: true,
                    textColor: Colors.black,
                    iconColor: Colors.grey,
                  ),
                  const SizedBox(height: 10),
                  ProfileWidget(
                    title: pMenu3,
                    icon: LineAwesomeIcons.user_tie_solid,
                    onTap: () {
                      showAdminDialog(context, userId!);
                    },
                    endIcon: true,
                    textColor: Colors.black,
                    iconColor: Colors.deepPurple,
                  ),
                  const SizedBox(height: 10),
                  ProfileWidget(
                    title: pMenu5,
                    icon: LineAwesomeIcons.sign_out_alt_solid,
                    onTap: () {
                      AuthenticationRepository().logOut();
                    },
                    endIcon: false,
                    textColor: Colors.red,
                    iconColor: Colors.red,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
