import 'meal_type.dart';

class MealLog {
  final String id;
  final String? userId;
  final DateTime logDate;
  final MealType mealType;
  final String? foodItemId;
  final String foodName;
  final double servingQty;
  final double servingSizeG;
  final double calories;
  final double proteinG;
  final double carbsG;
  final double fatsG;
  final String? notes;
  final String loggedVia;
  final DateTime? createdAt;

  const MealLog({
    required this.id,
    this.userId,
    required this.logDate,
    required this.mealType,
    this.foodItemId,
    required this.foodName,
    this.servingQty = 1,
    required this.servingSizeG,
    required this.calories,
    this.proteinG = 0,
    this.carbsG = 0,
    this.fatsG = 0,
    this.notes,
    this.loggedVia = 'manual',
    this.createdAt,
  });

  factory MealLog.fromJson(Map<String, dynamic> json) => MealLog(
        id: json['id'] as String,
        userId: json['user_id'] as String?,
        logDate: DateTime.parse(json['log_date'] as String),
        mealType: MealType.fromString(json['meal_type'] as String),
        foodItemId: json['food_item_id'] as String?,
        foodName: json['food_name'] as String,
        servingQty: (json['serving_qty'] as num?)?.toDouble() ?? 1,
        servingSizeG: (json['serving_size_g'] as num).toDouble(),
        calories: (json['calories'] as num).toDouble(),
        proteinG: (json['protein_g'] as num?)?.toDouble() ?? 0,
        carbsG: (json['carbs_g'] as num?)?.toDouble() ?? 0,
        fatsG: (json['fats_g'] as num?)?.toDouble() ?? 0,
        notes: json['notes'] as String?,
        loggedVia: json['logged_via'] as String? ?? 'manual',
        createdAt: json['created_at'] != null ? DateTime.parse(json['created_at'] as String) : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'log_date': logDate.toIso8601String().substring(0, 10),
        'meal_type': mealType.value,
        'food_item_id': foodItemId,
        'food_name': foodName,
        'serving_qty': servingQty,
        'serving_size_g': servingSizeG,
        'calories': calories,
        'protein_g': proteinG,
        'carbs_g': carbsG,
        'fats_g': fatsG,
        'notes': notes,
        'logged_via': loggedVia,
      };
}