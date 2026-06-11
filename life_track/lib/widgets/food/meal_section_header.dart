import 'package:flutter/material.dart';

class MealSectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final double totalCalories;

  const MealSectionHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.totalCalories,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: const Color(0xFF4A7C6A)),
            const SizedBox(width: 6),
            Text(title,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
          ],
        ),
        Text('${totalCalories.toStringAsFixed(0)} kcal',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF4A7C6A))),
      ],
    );
  }
}