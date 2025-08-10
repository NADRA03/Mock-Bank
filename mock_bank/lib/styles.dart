import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryGreen = Color(0xFF047857);
  static const Color positive = Color(0xFF10B981);
  static const Color negative = Color(0xFFDC2626);
  static const Color background = Colors.white;
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(fontSize: 18);
  static const TextStyle balance = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryGreen,
  );
  static const TextStyle positiveAmount = TextStyle(
    color: AppColors.positive,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle negativeAmount = TextStyle(
    color: AppColors.negative,
    fontWeight: FontWeight.bold,
  );
}

class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}
