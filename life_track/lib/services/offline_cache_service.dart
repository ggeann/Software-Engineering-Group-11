import 'package:hive_flutter/hive_flutter.dart';
import '../models/meal_log.dart';

class OfflineCacheService {
  static const String _mealLogsBox = 'meal_logs';
  static const String _budgetBox = 'daily_budget';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_mealLogsBox);
    await Hive.openBox(_budgetBox);
  }

  Future<void> saveMealLogs(DateTime date, List<MealLog> logs) async {
    final box = Hive.box(_mealLogsBox);
    final key = date.toIso8601String().substring(0, 10);
    await box.put(key, logs.map((l) => l.toJson()).toList());
  }

  Future<List<MealLog>> getMealLogs(DateTime date) async {
    final box = Hive.box(_mealLogsBox);
    final key = date.toIso8601String().substring(0, 10);
    final raw = box.get(key) as List?;
    if (raw == null) return [];
    return raw.map((item) => MealLog.fromJson(item as Map<String, dynamic>)).toList();
  }

  Future<void> clearAll() async {
    final box = Hive.box(_mealLogsBox);
    await box.clear();
  }
}