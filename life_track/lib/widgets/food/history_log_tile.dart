import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/meal_log.dart';

class HistoryLogTile extends ConsumerWidget {
  final MealLog log;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const HistoryLogTile({
    super.key,
    required this.log,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(log.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: const Color(0xFFEF4444),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (_) => _confirmDelete(context),
      onDismissed: (_) => onDelete?.call(),
      child: ListTile(
        title: Text(log.foodName,
            style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text('${log.servingSizeG.toStringAsFixed(0)}g serving'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${log.calories.toStringAsFixed(0)} kcal',
                style: const TextStyle(color: Color(0xFF6B7280))),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 18, color: Color(0xFF6B7280)),
              onPressed: () => onEdit?.call(),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete food log?'),
        content: Text('Remove "${log.foodName}" from your log?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Color(0xFFEF4444))),
          ),
        ],
      ),
    );
  }
}