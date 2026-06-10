import 'package:flutter/material.dart';
import '../../models/meal_type.dart';

class MealTypeDropdown extends StatelessWidget {
  final MealType selected;
  final ValueChanged<MealType> onChanged;

  const MealTypeDropdown({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<MealType>(
      value: selected,
      underline: const SizedBox(),
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
      items: MealType.values.map((type) => DropdownMenuItem(
        value: type,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(type.icon, size: 18, color: type.color),
            const SizedBox(width: 6),
            Text(type.displayName),
          ],
        ),
      )).toList(),
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
    );
  }
}