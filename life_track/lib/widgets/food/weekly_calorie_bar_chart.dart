import 'package:flutter/material.dart';
import '../../models/daily_summary.dart';

class WeeklyCalorieBarChart extends StatelessWidget {
  final List<DailySummary> weeklySummaries;
  final double goal;
  final ValueChanged<int>? onBarTapped;

  const WeeklyCalorieBarChart({
    super.key,
    required this.weeklySummaries,
    this.goal = 2100,
    this.onBarTapped,
  });

  @override
  Widget build(BuildContext context) {
    if (weeklySummaries.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: weeklySummaries.asMap().entries.map((entry) {
          final i = entry.key;
          final summary = entry.value;
          final isOver = summary.totalCalories > goal;
          final heightRatio = (summary.totalCalories / (goal * 1.2)).clamp(0.0, 1.0);
          final dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
          return Expanded(
            child: GestureDetector(
              onTap: () => onBarTapped?.call(i),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 100 * heightRatio,
                      width: 20,
                      decoration: BoxDecoration(
                        color: isOver ? const Color(0xFFE07070) : const Color(0xFF0D6E5C),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(dayLabels[i % dayLabels.length],
                        style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}