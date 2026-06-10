import 'package:flutter/material.dart';

class DailySummaryCard extends StatelessWidget {
  final double totalCalories;
  final double goalCalories;
  final double proteinG;
  final double carbsG;
  final double fatsG;

  const DailySummaryCard({
    super.key,
    required this.totalCalories,
    required this.goalCalories,
    this.proteinG = 0,
    this.carbsG = 0,
    this.fatsG = 0,
  });

  @override
  Widget build(BuildContext context) {
    final pct = goalCalories > 0 ? (totalCalories / goalCalories * 100).clamp(0, 100) : 0.0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Today's Summary",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
          const SizedBox(height: 8),
          Text('Calories: ${totalCalories.toStringAsFixed(0)} / ${goalCalories.toStringAsFixed(0)} kcal (${pct.toStringAsFixed(0)}%)',
              style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          const SizedBox(height: 8),
          Row(
            children: [
              _macroChip('Protein', proteinG, const Color(0xFF0D6E5C)),
              const SizedBox(width: 12),
              _macroChip('Carbs', carbsG, const Color(0xFF3B4A6B)),
              const SizedBox(width: 12),
              _macroChip('Fats', fatsG, const Color(0xFFE07070)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _macroChip(String label, double value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text('$label ${value.toStringAsFixed(0)}g',
            style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
      ],
    );
  }
}