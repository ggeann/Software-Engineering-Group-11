import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/food_item.dart';
import '../../models/meal_type.dart';
import '../../providers/food_nutrition_providers.dart';
import 'calorie_badge.dart';
import 'nutrition_mini_bar.dart';
import 'serving_selector.dart';

class FoodDetailSheet extends ConsumerStatefulWidget {
  final FoodItem food;
  final MealType targetMealType;

  const FoodDetailSheet({
    super.key,
    required this.food,
    required this.targetMealType,
  });

  @override
  ConsumerState<FoodDetailSheet> createState() => _FoodDetailSheetState();
}

class _FoodDetailSheetState extends ConsumerState<FoodDetailSheet> {
  double _servingQty = 1.0;

  double get _adjustedCalories => widget.food.caloriesPerServing * _servingQty;
  double get _adjustedProtein => widget.food.proteinG * _servingQty;
  double get _adjustedCarbs => widget.food.carbsG * _servingQty;
  double get _adjustedFats => widget.food.fatsG * _servingQty;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFDDE8DD),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.all(20),
                children: [
                  Text(widget.food.name,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  if (widget.food.brand != null)
                    Text(widget.food.brand!,
                        style: const TextStyle(color: Color(0xFF6B7280))),
                  const SizedBox(height: 16),
                  CalorieBadge(calories: _adjustedCalories),
                  const SizedBox(height: 16),
                  NutritionMiniBar(label: 'Protein', value: _adjustedProtein,
                      goal: 120, color: const Color(0xFF0D6E5C)),
                  NutritionMiniBar(label: 'Carbs', value: _adjustedCarbs,
                      goal: 250, color: const Color(0xFF3B4A6B)),
                  NutritionMiniBar(label: 'Fats', value: _adjustedFats,
                      goal: 70, color: const Color(0xFFE07070)),
                  const SizedBox(height: 20),
                  ServingSelector(
                    qty: _servingQty,
                    label: widget.food.servingDescription ?? '1 serving',
                    onChanged: (qty) => setState(() => _servingQty = qty),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addToMeal,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D6E5C),
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      'Add to ${widget.targetMealType.displayName}',
                      style: const TextStyle(color: Colors.white, fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addToMeal() async {
    final service = ref.read(supabaseFoodServiceProvider);
    try {
      await service.logMeal(
        foodItemId: widget.food.id,
        mealType: widget.targetMealType,
        servingQty: _servingQty,
        logDate: DateTime.now(),
      );
      ref.invalidate(mealLogsProvider(widget.targetMealType));
      ref.invalidate(dailyBudgetProvider);
      if (mounted) {
        Navigator.pop(context);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${widget.food.name} added!')),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        Navigator.pop(context);
        ref.invalidate(mealLogsProvider(widget.targetMealType));
        ref.invalidate(dailyBudgetProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${widget.food.name} added!'),
              backgroundColor: const Color(0xFF0D6E5C)),
        );
      }
    }
  }
}