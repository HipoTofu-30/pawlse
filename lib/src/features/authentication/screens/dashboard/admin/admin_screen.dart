import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pawlse/src/constants/text_strings.dart';
import 'package:pawlse/src/features/authentication/controllers/profile_controllers.dart';
import 'package:pawlse/src/features/authentication/screens/dashboard/admin/users_info.dart';
import 'package:pawlse/src/repository/user_repository/user_repository.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final controller = Get.put(ProfileControllers());
  final controller2 = Get.put(UserRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pUsers, style: Theme.of(context).textTheme.headlineLarge),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left_solid),
        ),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: controller2.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // 🔄 Loading
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}")); // ❌ Error
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No users found")); // ❌ No data
          }

          var users = snapshot.data!; // 🔹 List of user data

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index];

              return UserInfoContainer(
                userId: user["id"], // Pass user ID for updates
                name: user["name"] ?? "No Name",
                email: user["email"] ?? "No Email",
                phone: user["phone"] ?? "No Phone",
                accessToDisplay: user["accessToDisplay"] ?? false,
                petName: user["petName"] ?? "No Pet's Name",
                photoURL: user["photoURL"] ?? "No Photo",
                admin: user["admim"] ?? false,
              );
            },
          );
        },
      ),
    );
  }
}
