import 'package:flutter/material.dart';

enum MealType {
  breakfast('breakfast', Icons.wb_sunny_outlined, Color(0xFFFBBF24)),
  lunch('lunch', Icons.lunch_dining_outlined, Color(0xFF3B82F6)),
  dinner('dinner', Icons.nightlight_outlined, Color(0xFF8B5CF6)),
  snack('snack', Icons.cookie_outlined, Color(0xFFEC4899));

  final String value;
  final IconData icon;
  final Color color;
  const MealType(this.value, this.icon, this.color);

  String get displayName => '${name[0].toUpperCase()}${name.substring(1)}';

  static MealType fromString(String s) =>
      MealType.values.firstWhere((e) => e.value == s, orElse: () => MealType.breakfast);
}