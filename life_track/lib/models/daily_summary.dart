class DailySummary {
  final String id;
  final String userId;
  final DateTime summaryDate;
  final double totalCalories;
  final double totalProteinG;
  final double totalCarbsG;
  final double totalFatsG;
  final double breakfastCalories;
  final double lunchCalories;
  final double dinnerCalories;
  final double snackCalories;

  const DailySummary({
    required this.id,
    required this.userId,
    required this.summaryDate,
    this.totalCalories = 0,
    this.totalProteinG = 0,
    this.totalCarbsG = 0,
    this.totalFatsG = 0,
    this.breakfastCalories = 0,
    this.lunchCalories = 0,
    this.dinnerCalories = 0,
    this.snackCalories = 0,
  });

  factory DailySummary.fromJson(Map<String, dynamic> json) => DailySummary(
        id: json['id'] as String,
        userId: json['user_id'] as String,
        summaryDate: DateTime.parse(json['summary_date'] as String),
        totalCalories: (json['total_calories'] as num?)?.toDouble() ?? 0,
        totalProteinG: (json['total_protein_g'] as num?)?.toDouble() ?? 0,
        totalCarbsG: (json['total_carbs_g'] as num?)?.toDouble() ?? 0,
        totalFatsG: (json['total_fats_g'] as num?)?.toDouble() ?? 0,
        breakfastCalories: (json['breakfast_calories'] as num?)?.toDouble() ?? 0,
        lunchCalories: (json['lunch_calories'] as num?)?.toDouble() ?? 0,
        dinnerCalories: (json['dinner_calories'] as num?)?.toDouble() ?? 0,
        snackCalories: (json['snack_calories'] as num?)?.toDouble() ?? 0,
      );
}