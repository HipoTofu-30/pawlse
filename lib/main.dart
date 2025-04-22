import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:pawlse/firebase_options.dart';
import 'package:pawlse/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:pawlse/src/repository/authentication_repository/authentication_repository.dart';
import 'package:pawlse/src/services/notification_service.dart';
import 'package:pawlse/src/utils/theme/theme.dart';
import 'package:google_api_availability/google_api_availability.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleApiAvailability.instance.makeGooglePlayServicesAvailable();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Get.put(AuthenticationRepository());

  await NotificationService.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}
