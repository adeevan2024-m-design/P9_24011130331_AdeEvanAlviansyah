import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF4F46E5);
  static const Color violet = Color(0xFF7C3AED);
  static const Color ink = Color(0xFF1F2937);
  static const Color muted = Color(0xFF6B7280);
  static const Color surface = Color(0xFFF6F7FB);
  static const Color star = Color(0xFFF59E0B);

  static const LinearGradient brand = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, violet],
  );

  static const List<BoxShadow> softShadow = [
    BoxShadow(
      color: Color(0x141F2937),
      blurRadius: 18,
      offset: Offset(0, 8),
    ),
  ];
}
