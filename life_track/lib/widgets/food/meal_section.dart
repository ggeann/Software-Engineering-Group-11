import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/meal_log.dart';
import '../../models/meal_type.dart';
import '../../providers/food_nutrition_providers.dart';
import 'meal_section_header.dart';
import 'food_log_tile.dart';
import 'add_food_button.dart';
import 'log_final_meal_button.dart';

class MealSection extends ConsumerWidget {
  final MealType mealType;
  final VoidCallback? onAddFood;

  const MealSection({
    super.key,
    required this.mealType,
    this.onAddFood,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(mealLogsProvider(mealType));
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          logsAsync.when(
            data: (logs) => _buildContent(logs),
            loading: () => Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            error: (err, _) => Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(child: Text('Failed to load', style: TextStyle(color: Color(0xFF6B7280)))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(List<MealLog> logs) {
    final totalKcal = logs.fold<double>(0, (sum, log) => sum + log.calories);
    final isEmpty = logs.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MealSectionHeader(icon: mealType.icon, title: mealType.displayName, totalCalories: totalKcal),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6)],
          ),
          child: isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(14),
                  child: mealType == MealType.dinner
                      ? LogFinalMealButton(onTap: onAddFood)
                      : AddFoodButton(onTap: onAddFood),
                )
              : Column(
                  children: [
                    ...logs.map((log) => FoodLogTile(log: log)),
                    const Divider(height: 1, color: Color(0xFFF0F5F2)),
                    AddFoodButton(onTap: onAddFood),
                  ],
                ),
        ),
      ],
    );
  }
}