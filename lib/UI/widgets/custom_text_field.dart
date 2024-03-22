import 'package:firebase_auth_demo/utils/font_theme.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData iconData;
  final String hintText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.iconData,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: color.primary),
            borderRadius: BorderRadius.circular(20)),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintStyle: bodyFontStyle(context, color.secondary),
            iconColor: color.primaryContainer,
            prefixIconColor: color.tertiary,
            border: InputBorder.none,
            prefixIcon: Icon(iconData),
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
