import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme{
  static const primaryColor=Colors.deepPurple;
  static ThemeData mainTheme=ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      iconTheme: const IconThemeData(
        color: primaryColor,
      )
    ),
    primaryColor: primaryColor,
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 25.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      bodyLarge: GoogleFonts.poppins(
      fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: primaryColor[900],
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    )
  );
}