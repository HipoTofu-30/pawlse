import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pawlse/src/constants/colors.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap,
      required this.endIcon,
      required this.textColor,
      required this.iconColor});

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool endIcon;
  final Color? textColor;

  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: pAccentColor.withOpacity(0.1)),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.apply(color: textColor),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1)),
              child: const Icon(
                LineAwesomeIcons.angle_right_solid,
                color: Colors.grey,
              ),
            )
          : null,
    );
  }
}
