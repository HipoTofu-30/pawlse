import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawlse/src/constants/images_text.dart';
import 'package:pawlse/src/constants/sizes.dart';
import 'package:pawlse/src/cool_app_bar.dart';
import 'package:pawlse/src/features/authentication/screens/dashboard/user/display_format.dart';
import 'package:pawlse/src/features/authentication/screens/dashboard/user/request_pet_name.dart';
import 'package:pawlse/src/features/authentication/screens/message/message_screen.dart';
import 'package:pawlse/src/repository/authentication_repository/authentication_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool hasPromptedForName = false;

  // Updated with correct region-specific URL
  final databaseRef = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
        "https://pawlse-420c0-default-rtdb.asia-southeast1.firebasedatabase.app",
  ).ref().child("Monitor");

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;
    String? userId = AuthenticationRepository().getCurrentUserId();

    if (userId == null) {
      return const Scaffold(
        body: Center(child: Text("No user signed in ❌")),
      );
    }

    return Scaffold(
      appBar: buildCoolAppBar(),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(userId)
            .snapshots(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
            return const Center(child: Text("User data not found ❌"));
          }

          var userData = userSnapshot.data!;
          String userName = userData["name"] ?? "User";
          bool accessToDisplay = userData["accessToDisplay"] ?? false;
          String petName = userData["petName"] ?? "none";
          String dogFur = userData["dogFurType"] ?? "Not set";

          if (petName == "none" && !hasPromptedForName) {
            hasPromptedForName = true;
            Future.delayed(
              Duration.zero,
              () => requestPetName(context, userId),
            );
          }

          return StreamBuilder<DatabaseEvent>(
            stream: databaseRef.onValue,
            builder: (context, eventSnapshot) {
              if (eventSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final snapshotValue = eventSnapshot.data?.snapshot.value;

              double heartRate = 0;

              double temperature = 0;

              if (snapshotValue is Map) {
                final Map<String, dynamic> realTimeData =
                    Map<String, dynamic>.from(snapshotValue);

                heartRate = ((realTimeData["heartRate"] ?? 0).toDouble() * 100)
                        .roundToDouble() /
                    100;
                temperature =
                    ((realTimeData["temperature"] ?? 0).toDouble() * 100)
                            .roundToDouble() /
                        100;
              } else {
                return const Center(
                    child: Text("Invalid real-time data format ❌"));
              }

              double adjustedTemp = temperature;

              if (dogFur == "Thicker") {
                adjustedTemp += 7;
              } else if (dogFur == "Dense") {
                adjustedTemp += 7;
              } else if (dogFur == "Thin") {
                adjustedTemp += 3;
              } else if (dogFur == "Thick") {
                adjustedTemp += 5;
              }
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(pdashboardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome $userName!", style: txtTheme.headlineLarge),
                      Text("How is $petName doing?", style: txtTheme.bodyLarge),
                      Text("$petName has $dogFur fur",
                          style: txtTheme.bodyLarge),
                      const Divider(thickness: 4, color: Colors.brown),
                      DisplayFormat(
                        txtTheme: txtTheme,
                        logo: pHartLogo,
                        title: "Heart Rate",
                        value: accessToDisplay ? heartRate : 0,
                        access: accessToDisplay
                            ? null
                            : "Access Temporarily turned off",
                        sign: " BP/M",
                      ),

                      const SizedBox(height: pdashboardPadding),
                      DisplayFormat(
                        txtTheme: txtTheme,
                        logo: ptempLogo,
                        title: "Body Temperature",
                        value: accessToDisplay ? adjustedTemp : 0,
                        access: accessToDisplay
                            ? null
                            : "Access Temporarily turned off",
                        sign: " °C",
                      ),

                      // 👇 New Article Section
                      const SizedBox(height: pdashboardPadding * 2),
                      Text(
                        "To know more about your pet, here are some articles you can read!",
                        style: txtTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: pdashboardPadding),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => launchUrl(Uri.parse(
                                "https://neurosciencenews.com/dog-human-heart-synch-27996/")),
                            child: Text(
                              "🐶 Emotional Bonding: How Dog-Owner Heart Rates Sync During Interaction",
                              style: txtTheme.bodyLarge?.copyWith(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          const SizedBox(height: pdashboardPadding / 2),
                          GestureDetector(
                            onTap: () => launchUrl(Uri.parse(
                                "https://www.thesprucepets.com/normal-temperature-heart-rates-in-dogs-4143223")),
                            child: Text(
                              "🐾 Normal Temperature, Heart, and Respiratory Rates in Dogs",
                              style: txtTheme.bodyLarge?.copyWith(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          const SizedBox(height: pdashboardPadding / 2),
                          GestureDetector(
                            onTap: () => launchUrl(Uri.parse(
                                "https://www.psypost.org/dogs-and-owners-hearts-sync-during-interactions-research-finds/")),
                            child: Text(
                              "🐕‍🦺 Dogs’ and owners’ hearts sync during interactions",
                              style: txtTheme.bodyLarge?.copyWith(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      // ignore: unnecessary_null_comparison
      floatingActionButton: userId != null
          ? StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(userId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const SizedBox.shrink();
                }

                bool isAdmin = snapshot.data!["admin"] ?? false;
                if (isAdmin) return const SizedBox.shrink();

                return FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MessageScreen(
                          receiverUserEmail: "pawlse.ad@gmail.com",
                          receiverUserId: "v4oI05bjIBaTlXHIhYo8bPbrWB93",
                        ),
                      ),
                    );
                  },
                  backgroundColor: Colors.brown,
                  child: const Icon(Icons.message, color: Colors.white),
                );
              },
            )
          : null,
    );
  }
}
