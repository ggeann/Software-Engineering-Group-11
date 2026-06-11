import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/food_item.dart';
import '../models/meal_log.dart';
import '../models/daily_budget.dart';
import '../models/daily_summary.dart';
import '../models/meal_type.dart';

class FoodApiService {
  final Dio _dio;
  final SupabaseClient _supabase;
  static const String _baseUrl = 'http://localhost:3000/api/v1';

  FoodApiService({required SupabaseClient supabase})
      : _supabase = supabase,
        _dio = Dio(BaseOptions(baseUrl: _baseUrl)) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final session = _supabase.auth.currentSession;
        if (session != null) {
          options.headers['Authorization'] = 'Bearer ${session.accessToken}';
        }
        handler.next(options);
      },
    ));
  }

  Future<DailyBudget> getDailyBudget({required DateTime date}) async {
    final response = await _dio.get('/nutrition/budget',
        queryParameters: {'date': DateFormat('yyyy-MM-dd').format(date)});
    return DailyBudget.fromJson(response.data['data']);
  }

  Future<List<FoodItem>> searchFoods({required String query, int limit = 20}) async {
    final response = await _dio.get('/food/search',
        queryParameters: {'q': query, 'limit': limit});
    return (response.data['data'] as List)
        .map((item) => FoodItem.fromJson(item))
        .toList();
  }

  Future<List<FoodItem>> getRecentFoods({int limit = 10}) async {
    final response = await _dio.get('/food/search', queryParameters: {'limit': limit});
    return (response.data['data'] as List)
        .map((item) => FoodItem.fromJson(item))
        .toList();
  }

  Future<List<MealLog>> getMealLogsByType({required DateTime date, required MealType mealType}) async {
    final response = await _dio.get('/meals/today',
        queryParameters: {'meal_type': mealType.value});
    return (response.data['data'] as List)
        .map((item) => MealLog.fromJson(item))
        .toList();
  }

  Future<List<MealLog>> getMealLogsByDate({required DateTime date}) async {
    final response = await _dio.get('/meals/date/${DateFormat('yyyy-MM-dd').format(date)}');
    return (response.data['data'] as List)
        .map((item) => MealLog.fromJson(item))
        .toList();
  }

  Future<MealLog> logMeal({
    required String foodItemId,
    required MealType mealType,
    required double servingQty,
    required DateTime logDate,
  }) async {
    final response = await _dio.post('/meals', data: {
      'food_item_id': foodItemId,
      'meal_type': mealType.value,
      'serving_qty': servingQty,
      'log_date': DateFormat('yyyy-MM-dd').format(logDate),
      'logged_via': 'manual',
    });
    return MealLog.fromJson(response.data['data']);
  }

  Future<void> deleteMealLog(String logId) async {
    await _dio.delete('/meals/$logId');
  }

  Future<MealLog> updateMealLog(String logId, {double? servingQty, String? notes}) async {
    final response = await _dio.put('/meals/$logId', data: {
      'serving_qty': ?servingQty,
      'notes': ?notes,
    });
    return MealLog.fromJson(response.data['data']);
  }

  Future<List<DailySummary>> getWeeklySummaries({required DateTime from, required DateTime to}) async {
    final response = await _dio.get('/nutrition/weekly',
        queryParameters: {
          'from': DateFormat('yyyy-MM-dd').format(from),
          'to': DateFormat('yyyy-MM-dd').format(to),
        });
    return (response.data['data'] as List)
        .map((item) => DailySummary.fromJson(item))
        .toList();
  }
}