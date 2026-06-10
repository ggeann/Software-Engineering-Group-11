import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/food_item.dart';
import '../models/meal_log.dart';
import '../models/daily_budget.dart';
import '../models/daily_summary.dart';
import '../models/meal_type.dart';

class SupabaseFoodService {
  final SupabaseClient _client;
  SupabaseFoodService(this._client);

  Future<List<FoodItem>> searchFoods({required String query, int limit = 20}) async {
    final response = await _client
        .from('food_items')
        .select()
        .textSearch('name', query)
        .limit(limit);
    return (response as List).map((json) => FoodItem.fromJson(json)).toList();
  }

  Future<List<FoodItem>> getRecentFoods({int limit = 10}) async {
    final response = await _client
        .from('food_items')
        .select()
        .order('updated_at', ascending: false)
        .limit(limit);
    return (response as List).map((json) => FoodItem.fromJson(json)).toList();
  }

  Future<DailyBudget> getDailyBudget({required DateTime date}) async {
    final dateStr = date.toIso8601String().substring(0, 10);

    final logs = await _client
        .from('meal_logs')
        .select('calories, protein_g, carbs_g, fats_g')
        .eq('log_date', dateStr);

    final consumed = (logs as List).fold<double>(0, (s, l) => s + (l['calories'] as num).toDouble());
    final protein = (logs as List).fold<double>(0, (s, l) => s + (l['protein_g'] as num).toDouble());
    final carbs = (logs as List).fold<double>(0, (s, l) => s + (l['carbs_g'] as num).toDouble());
    final fats = (logs as List).fold<double>(0, (s, l) => s + (l['fats_g'] as num).toDouble());

    return DailyBudget(
      date: dateStr,
      goalKcal: 2100,
      consumedKcal: consumed,
      remainingKcal: (2100 - consumed).clamp(0, 9999),
      percentageUsed: 2100 > 0 ? double.parse(((consumed / 2100) * 100).toStringAsFixed(1)) : 0,
      macros: {
        'protein': MacroDetail(consumedG: protein, goalG: 120, percentage: 120 > 0 ? double.parse(((protein / 120) * 100).toStringAsFixed(1)) : 0),
        'carbs': MacroDetail(consumedG: carbs, goalG: 250, percentage: 250 > 0 ? double.parse(((carbs / 250) * 100).toStringAsFixed(1)) : 0),
        'fats': MacroDetail(consumedG: fats, goalG: 70, percentage: 70 > 0 ? double.parse(((fats / 70) * 100).toStringAsFixed(1)) : 0),
      },
    );
  }

  Future<List<MealLog>> getMealLogsByType({required DateTime date, required MealType mealType}) async {
    final dateStr = date.toIso8601String().substring(0, 10);
    final response = await _client
        .from('meal_logs')
        .select()
        .eq('log_date', dateStr)
        .eq('meal_type', mealType.value)
        .order('created_at');
    return (response as List).map((json) => MealLog.fromJson(json)).toList();
  }

  Future<MealLog> logMeal({
    required String foodItemId,
    required MealType mealType,
    required double servingQty,
    required DateTime logDate,
  }) async {
    final food = await _client.from('food_items').select().eq('id', foodItemId).single();

    final response = await _client.from('meal_logs').insert({
      'food_item_id': foodItemId,
      'meal_type': mealType.value,
      'food_name': food['name'],
      'serving_qty': servingQty,
      'serving_size_g': (food['serving_size_g'] as num).toDouble() * servingQty,
      'calories': (food['calories_per_serving'] as num).toDouble() * servingQty,
      'protein_g': (food['protein_g'] as num).toDouble() * servingQty,
      'carbs_g': (food['carbs_g'] as num).toDouble() * servingQty,
      'fats_g': (food['fats_g'] as num).toDouble() * servingQty,
      'log_date': logDate.toIso8601String().substring(0, 10),
      'logged_via': 'manual',
    }).select().single();

    return MealLog.fromJson(response);
  }

  Future<void> deleteMealLog(String logId) async {
    await _client.from('meal_logs').delete().eq('id', logId);
  }

  Future<List<MealLog>> getMealLogsByDate({required DateTime date}) async {
    final dateStr = date.toIso8601String().substring(0, 10);
    final response = await _client
        .from('meal_logs')
        .select()
        .eq('log_date', dateStr)
        .order('created_at');
    return (response as List).map((json) => MealLog.fromJson(json)).toList();
  }

  Future<List<DailySummary>> getWeeklySummaries({required DateTime from, required DateTime to}) async {
    final response = await _client
        .from('daily_summaries')
        .select()
        .gte('summary_date', from.toIso8601String().substring(0, 10))
        .lte('summary_date', to.toIso8601String().substring(0, 10))
        .order('summary_date');
    return (response as List).map((json) => DailySummary.fromJson(json)).toList();
  }
}