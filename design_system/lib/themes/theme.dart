import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF333333),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: AppBarTheme(
      color: Color(0xFFFFFFFF),
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: const Color(0xff333333),
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: const Color(0xff555555),
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: const Color(0xff333333),
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: const Color(0xff333333),
      ),
    ),
  );
}

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.poppins().fontFamily,
    primaryColor: const Color(0xffFFFFFF),
    scaffoldBackgroundColor: const Color(0xff151515),
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: const Color(0xffFFFFFF),
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: const Color(0xff767373),
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: const Color(0xffFFFFFF),
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: const Color(0xffFFFFFF),
      ),
    ),
  );
}
