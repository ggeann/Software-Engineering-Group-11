import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/meal_log.dart';

class FoodLogTile extends ConsumerWidget {
  final MealLog log;
  final VoidCallback? onDismissed;
  final VoidCallback? onTap;

  const FoodLogTile({
    super.key,
    required this.log,
    this.onDismissed,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(log.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        decoration: const BoxDecoration(
          color: Color(0xFFFFEEEE),
          borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
        ),
        child: const Icon(Icons.delete_outline, color: Color(0xFFFF6B6B)),
      ),
      onDismissed: (_) => onDismissed?.call(),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(log.foodName,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111827))),
                    Text('${log.servingSizeG.toStringAsFixed(0)}g',
                        style: const TextStyle(fontSize: 12, color: Color(0xFF9ABAA8))),
                  ],
                ),
              ),
              Text('${log.calories.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF0D6E5C))),
            ],
          ),
        ),
      ),
    );
  }
}