import 'package:flutter/material.dart';

class CalorieBadge extends StatelessWidget {
  final double calories;

  const CalorieBadge({super.key, required this.calories});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5F2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_fire_department, color: Color(0xFF0D6E5C), size: 20),
          const SizedBox(width: 6),
          Text(
            '${calories.toStringAsFixed(0)} kcal',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0D6E5C)),
          ),
        ],
      ),
    );
  }
}