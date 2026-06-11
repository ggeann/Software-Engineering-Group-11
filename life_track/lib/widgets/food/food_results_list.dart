import 'package:flutter/material.dart';

class FoodResultsList extends StatelessWidget {
  final List<dynamic> foods;
  final void Function(dynamic food) onTap;

  const FoodResultsList({
    super.key,
    required this.foods,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (foods.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.search_off, size: 48, color: Color(0xFF9CA3AF)),
              SizedBox(height: 12),
              Text('No food found',
                  style: TextStyle(fontSize: 16, color: Color(0xFF6B7280))),
              Text('Try a different search term',
                  style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF))),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: foods.length,
      separatorBuilder: (_, _) => const Divider(height: 1, indent: 16, endIndent: 16),
      itemBuilder: (_, i) {
        final food = foods[i];
        return ListTile(
          leading: const Icon(Icons.restaurant, color: Color(0xFF0D6E5C)),
          title: Text(food.name as String,
              style: const TextStyle(fontWeight: FontWeight.w500)),
          subtitle: Text('${food.caloriesPerServing.toStringAsFixed(0)} kcal per ${food.servingSizeG.toStringAsFixed(0)}g'),
          trailing: const Icon(Icons.add_circle_outline, color: Color(0xFF0D6E5C)),
          onTap: () => onTap(food),
        );
      },
    );
  }
}