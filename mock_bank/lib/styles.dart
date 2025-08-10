import 'package:flutter/material.dart';

class AppColors {
  static const primaryGreen = Color(0xFF047857);
  static const positive = Color(0xFF10B981);
  static const negative = Color(0xFFDC2626);
  static const background = Colors.white;
  static const cardBackground = Color(0xFFF9FAFB);
}

class AppTextStyles {
  static const heading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black, 
  );
  static const balance = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryGreen,
  );
  static const positiveAmount = TextStyle(
    color: AppColors.positive,
    fontWeight: FontWeight.bold,
  );
  static const negativeAmount = TextStyle(
    color: AppColors.negative,
    fontWeight: FontWeight.bold,
  );
}

class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
}
