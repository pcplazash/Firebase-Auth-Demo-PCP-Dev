import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle titleFontStyle(BuildContext context, Color textColor) {
  return GoogleFonts.merriweather(
    fontWeight: FontWeight.w500,
    color: textColor,
    fontSize: 16,
  );
}

TextStyle bodyFontStyle(BuildContext context, Color textColor) {
  return GoogleFonts.jost(
      fontWeight: FontWeight.w500, color: textColor, fontSize: 16);
}
