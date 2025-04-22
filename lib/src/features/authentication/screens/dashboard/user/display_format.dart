import 'package:flutter/material.dart';
import 'package:pawlse/src/constants/sizes.dart';

class DisplayFormat extends StatelessWidget {
  const DisplayFormat({
    super.key,
    required this.txtTheme,
    required this.logo,
    required this.title,
    required this.value,
    this.access,
    required this.sign,
  });

  final TextTheme txtTheme;
  final String logo, title, sign;
  final double value;
  final String? access;

  Widget checkAccess(String? access) {
    if (access == null) {
      return const SizedBox(); // Return an empty widget instead of null
    }
    return Container(
      color: Colors.black, // High contrast background
      padding: const EdgeInsets.all(8),
      child: Text(
        access,
        style: txtTheme.titleMedium?.copyWith(color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Image(image: AssetImage(logo), width: 100)),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(title, style: txtTheme.bodyMedium),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(value.toStringAsFixed(2),
                        style: txtTheme.headlineLarge),
                    Text(sign, style: txtTheme.bodyLarge),
                  ],
                ),
                checkAccess(access),
                const SizedBox(
                  height: pdashboardPadding,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
