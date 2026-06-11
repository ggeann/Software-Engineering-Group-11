import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const heading1 = TextStyle(
    fontSize: 28, fontWeight: FontWeight.bold,
    color: AppColors.textPrimary, letterSpacing: -0.5);

  static const heading2 = TextStyle(
    fontSize: 22, fontWeight: FontWeight.bold,
    color: AppColors.textPrimary);

  static const heading3 = TextStyle(
    fontSize: 18, fontWeight: FontWeight.w600,
    color: AppColors.textPrimary);

  static const bodyLarge = TextStyle(
    fontSize: 16, fontWeight: FontWeight.normal,
    color: AppColors.textPrimary);

  static const bodyMedium = TextStyle(
    fontSize: 14, color: AppColors.textPrimary);

  static const caption = TextStyle(
    fontSize: 12, color: AppColors.textSecondary);

  static const calorieBig = TextStyle(
    fontSize: 32, fontWeight: FontWeight.bold,
    color: AppColors.textPrimary, letterSpacing: -1.0);
}