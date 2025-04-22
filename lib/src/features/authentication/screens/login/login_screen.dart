import 'package:flutter/material.dart';
import 'package:pawlse/src/common_widget/form/form_header_widget.dart';
import 'package:pawlse/src/constants/images_text.dart';
import 'package:pawlse/src/constants/sizes.dart';
import 'package:pawlse/src/constants/text_strings.dart';
import 'package:pawlse/src/features/authentication/screens/login/login_footer.dart';
import 'package:pawlse/src/features/authentication/screens/login/loginform.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(pDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: pFormHeight + 30,
                ),
                const FormHeaderWidget(
                    image: pwelcomeIMG,
                    subTitle: pLoginSubTitle,
                    title: pLoginTitle),
                LogInForm(),
                const LogInFooter()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
