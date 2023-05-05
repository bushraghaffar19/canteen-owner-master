import 'package:canteen_owner_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AppFonts {
  // ===========================================================================
  // 16 pixels
  // ===========================================================================
  static const TextStyle kFont12pt = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
   static const TextStyle kFont12ptGrey = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.kLightGreyColor,
  );
  static const TextStyle kFont14pt = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static const TextStyle kFont16pt = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );
  static const TextStyle kFont16ptWhite = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  static const TextStyle kFont16ptGrey = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.kLightGreyColor,
  );
  static const TextStyle kFont16ptBoldPrimary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w900,
    color: AppColors.kButtonColor,
  );
  static const TextStyle kFont16ptBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w900,
    color: Colors.black,
  );
  static const TextStyle kFont16ptUnderlineBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.black,
    decoration: TextDecoration.underline,
  );
  // ===========================================================================
  // 24 Pixels
  // ===========================================================================
  static const TextStyle kFont24ptBold = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    color: Colors.black,
  );
  static const TextStyle khead = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
    color: Colors.black,
    letterSpacing: 3,
    fontFamily: 'Open Sans'
  );
}
