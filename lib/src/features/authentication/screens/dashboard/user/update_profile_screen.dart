import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pawlse/src/constants/colors.dart';
import 'package:pawlse/src/constants/images_text.dart';
import 'package:pawlse/src/constants/sizes.dart';
import 'package:pawlse/src/constants/text_strings.dart';
import 'package:pawlse/src/features/authentication/controllers/profile_controllers.dart';
import 'package:pawlse/src/features/authentication/models/user_model.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileControllers());
    return Scaffold(
      appBar: AppBar(
        title: Text(pEditProfile,
            style: Theme.of(context).textTheme.headlineLarge),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(LineAwesomeIcons.angle_left_solid)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(pDefaultSize),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  return Column(
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child:
                                  const Image(image: AssetImage(pwelcomeIMG)),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: pPrimaryColor),
                              child: IconButton(
                                icon: const Icon(LineAwesomeIcons.camera_solid),
                                color: Colors.black,
                                onPressed: () {
                                  Get.to(() => const UpdateProfileScreen());
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Form(
                          child: Column(
                        children: [
                          TextFormField(
                            initialValue: userData.fullName,
                            decoration: const InputDecoration(
                                label: Text(pFullName),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.person_outline_rounded,
                                    color: pSecondaryColor),
                                labelStyle: TextStyle(color: pSecondaryColor),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2.0, color: pSecondaryColor))),
                          ),
                          const SizedBox(
                            height: pFormHeight - 20,
                          ),
                          TextFormField(
                            initialValue: userData.email,
                            decoration: const InputDecoration(
                                label: Text(pEmail),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email_outlined,
                                    color: pSecondaryColor),
                                labelStyle: TextStyle(color: pSecondaryColor),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2.0, color: pSecondaryColor))),
                          ),
                          const SizedBox(
                            height: pFormHeight - 20,
                          ),
                          TextFormField(
                            initialValue: userData.phoneNo,
                            decoration: const InputDecoration(
                                label: Text(pPhoneNo),
                                border: OutlineInputBorder(),
                                prefixIcon:
                                    Icon(Icons.numbers, color: pSecondaryColor),
                                labelStyle: TextStyle(color: pSecondaryColor),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2.0, color: pSecondaryColor))),
                          ),
                          const SizedBox(
                            height: pFormHeight - 20,
                          ),
                          TextFormField(
                            initialValue: userData.password,
                            decoration: const InputDecoration(
                                label: Text(pPassword),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.fingerprint,
                                    color: pSecondaryColor),
                                labelStyle: TextStyle(color: pSecondaryColor),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2.0, color: pSecondaryColor))),
                          ),
                          const SizedBox(
                            height: pFormHeight,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () =>
                                    Get.to(() => const UpdateProfileScreen()),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: pPrimaryColor,
                                    side: BorderSide.none,
                                    shape: const StadiumBorder()),
                                child: const Text(pEditProfile)),
                          ),
                          const SizedBox(
                            height: pFormHeight,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text.rich(TextSpan(
                                  text: pJoined,
                                  style: TextStyle(fontSize: 12),
                                  children: [
                                    TextSpan(
                                        text: pJoinedDate,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: pPrimaryColor))
                                  ])),
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.redAccent.withOpacity(0.1),
                                      elevation: 0,
                                      foregroundColor: Colors.red),
                                  child: const Text(pDelete))
                            ],
                          )
                        ],
                      ))
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error - $snapshot.error"));
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
