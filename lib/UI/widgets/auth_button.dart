import 'package:flutter/material.dart';

import '../../utils/font_theme.dart';

class AuthButton extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Function()? onTap;

  const AuthButton({
    super.key,
    required this.iconData,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final color = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width * 0.7,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
              color: color.secondaryContainer),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(iconData, color: color.secondary,),
              ),
              Text(
                title,
                style: bodyFontStyle(context, color.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
