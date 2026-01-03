import 'package:drive_resq/core/styles/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  // Headers
  static final header = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static final subHeader = GoogleFonts.poppins(
    fontSize: 14,
    color: Colors.grey[700],
  );

  static final button = GoogleFonts.poppins(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  static final link = GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    color: AppColors.primaryColor,
  );
}
