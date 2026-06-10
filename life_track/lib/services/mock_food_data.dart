import '../models/food_item.dart';
import '../models/meal_log.dart';
import '../models/daily_budget.dart';
import '../models/daily_summary.dart';
import '../models/meal_type.dart';

class MockFoodData {
  static const _todayStr = '2024-01-15';

  static DailyBudget mockBudget() => DailyBudget(
        date: _todayStr,
        goalKcal: 2100,
        consumedKcal: 460,
        remainingKcal: 1640,
        percentageUsed: 21.9,
        macros: {
          'protein': MacroDetail(consumedG: 84, goalG: 120, percentage: 70),
          'carbs': MacroDetail(consumedG: 142, goalG: 250, percentage: 56.8),
          'fats': MacroDetail(consumedG: 56, goalG: 70, percentage: 80),
        },
      );

  static List<FoodItem> mockFoods(String query) => [
        FoodItem(
          id: '1', name: 'Grilled Chicken Breast',
          servingSizeG: 100, caloriesPerServing: 165, proteinG: 31, carbsG: 0, fatsG: 3.6,
        ),
        FoodItem(
          id: '2', name: 'Chicken Curry',
          servingSizeG: 250, servingDescription: '1 serving', caloriesPerServing: 280, proteinG: 25, carbsG: 12, fatsG: 14,
        ),
        FoodItem(
          id: '3', name: 'Greek Yogurt & Berries',
          servingSizeG: 250, servingDescription: '250g serving', caloriesPerServing: 220, proteinG: 15, carbsG: 28, fatsG: 5,
        ),
      ];

  static List<MealLog> mockMealLogs(MealType type) {
    if (type == MealType.breakfast) {
      return [
        MealLog(id: 'b1', logDate: DateTime.now(), mealType: MealType.breakfast,
            foodName: 'Greek Yogurt & Berries', servingSizeG: 250, calories: 220, proteinG: 15, carbsG: 28, fatsG: 5),
        MealLog(id: 'b2', logDate: DateTime.now(), mealType: MealType.breakfast,
            foodName: 'Almonds', servingSizeG: 15, calories: 120, proteinG: 4, carbsG: 6, fatsG: 10),
      ];
    }
    if (type == MealType.lunch) {
      return [
        MealLog(id: 'l1', logDate: DateTime.now(), mealType: MealType.lunch,
            foodName: 'Grilled Chicken Salad', servingSizeG: 300, calories: 120, proteinG: 20, carbsG: 8, fatsG: 2, notes: 'Logged via QuickScan'),
      ];
    }
    return [];
  }

  static List<MealLog> mockHistoryLogs(DateTime date) => [
        MealLog(id: 'h1', logDate: date, mealType: MealType.breakfast,
            foodName: 'Oatmeal', servingSizeG: 200, calories: 180, proteinG: 6, carbsG: 30, fatsG: 3),
        MealLog(id: 'h2', logDate: date, mealType: MealType.lunch,
            foodName: 'Chicken Wrap', servingSizeG: 250, calories: 350, proteinG: 28, carbsG: 30, fatsG: 12),
      ];

  static List<DailySummary> mockWeeklySummaries() {
    final today = DateTime.now();
    return List.generate(7, (i) {
      final d = today.subtract(Duration(days: 6 - i));
      return DailySummary(
        id: 'ws$i', userId: 'u1', summaryDate: d,
        totalCalories: [1800, 2100, 1650, 1950, 2200, 1400, 1880][i].toDouble(),
      );
    });
  }
}