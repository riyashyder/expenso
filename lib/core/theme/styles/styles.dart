import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppThemeData {
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color darkPurple = Color(0xFFAF00DD);
  static const Color lightPurple = Color(0xFFE7B6FF);
  static const Color darkViolet = Color(0xFF460058);
  static const Color lightPurpleLabel = Color(0xFF710EB6);

  static const String commonStrings = "common Strings";

  //textstyles


  static TextStyle get headingStyle {
    return GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: darkPurple,
    );
  }

  static TextStyle get smallSubheadingStyle {
    return GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: darkPurple,
    );
  }
}