import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/meal_log.dart';
import '../../models/meal_type.dart';
import '../../providers/food_nutrition_providers.dart';
import 'history_log_tile.dart';
import 'edit_meal_log_sheet.dart';

class HistoryMealSection extends ConsumerWidget {
  final MealType mealType;
  final List<MealLog> logs;

  const HistoryMealSection({
    super.key,
    required this.mealType,
    required this.logs,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (logs.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(mealType.icon, size: 18, color: mealType.color),
            const SizedBox(width: 8),
            Text('${mealType.displayName}  0 kcal',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF6B7280))),
          ],
        ),
      );
    }

    final totalKcal = logs.fold<double>(0, (s, l) => s + l.calories);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Row(
            children: [
              Icon(mealType.icon, size: 18, color: mealType.color),
              const SizedBox(width: 8),
              Text('${mealType.displayName}  ${totalKcal.toStringAsFixed(0)} kcal',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: logs.map((log) => HistoryLogTile(
              log: log,
              onEdit: () => _editLog(context, ref, log),
              onDelete: () => _deleteLog(ref, log),
            )).toList(),
          ),
        ),
      ],
    );
  }

  void _editLog(BuildContext context, WidgetRef ref, MealLog log) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => EditMealLogSheet(log: log),
    );
  }

  Future<void> _deleteLog(WidgetRef ref, MealLog log) async {
    try {
      final service = ref.read(supabaseFoodServiceProvider);
      await service.deleteMealLog(log.id);
    } catch (_) {}
    ref.invalidate(historyMealLogsProvider(log.logDate));
    ref.invalidate(dailyBudgetProvider);
  }
}