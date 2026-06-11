import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/food_item.dart';
import '../models/meal_log.dart';
import '../models/daily_budget.dart';
import '../models/daily_summary.dart';
import '../models/meal_type.dart';
import '../services/supabase_food_service.dart';
import '../services/mock_food_data.dart';

final supabaseProvider = Provider<SupabaseClient>((ref) => Supabase.instance.client);

final supabaseFoodServiceProvider = Provider<SupabaseFoodService>((ref) {
  final supabase = ref.watch(supabaseProvider);
  return SupabaseFoodService(supabase);
});

final dailyBudgetProvider = FutureProvider<DailyBudget>((ref) async {
  try {
    final service = ref.read(supabaseFoodServiceProvider);
    return await service.getDailyBudget(date: DateTime.now());
  } catch (_) {
    return MockFoodData.mockBudget();
  }
});

final mealLogsProvider = FutureProvider.family<List<MealLog>, MealType>((ref, mealType) async {
  try {
    final service = ref.read(supabaseFoodServiceProvider);
    return await service.getMealLogsByType(date: DateTime.now(), mealType: mealType);
  } catch (_) {
    return MockFoodData.mockMealLogs(mealType);
  }
});

final foodSearchProvider = FutureProvider.family<List<FoodItem>, String>((ref, query) async {
  if (query.isEmpty) return [];
  try {
    final service = ref.read(supabaseFoodServiceProvider);
    return await service.searchFoods(query: query, limit: 20);
  } catch (_) {
    return MockFoodData.mockFoods(query);
  }
});

final recentFoodsProvider = FutureProvider<List<FoodItem>>((ref) async {
  try {
    final service = ref.read(supabaseFoodServiceProvider);
    return await service.getRecentFoods(limit: 10);
  } catch (_) {
    return MockFoodData.mockFoods('');
  }
});

final historyMealLogsProvider = FutureProvider.family<List<MealLog>, DateTime>((ref, date) async {
  try {
    final service = ref.read(supabaseFoodServiceProvider);
    return await service.getMealLogsByDate(date: date);
  } catch (_) {
    return MockFoodData.mockHistoryLogs(date);
  }
});

final weeklySummariesProvider = FutureProvider<List<DailySummary>>((ref) async {
  try {
    final service = ref.read(supabaseFoodServiceProvider);
    final today = DateTime.now();
    final weekAgo = today.subtract(const Duration(days: 6));
    return await service.getWeeklySummaries(from: weekAgo, to: today);
  } catch (_) {
    return MockFoodData.mockWeeklySummaries();
  }
});