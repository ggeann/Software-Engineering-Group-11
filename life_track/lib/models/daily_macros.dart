class DailyMacros {
  final double proteinG;
  final double carbsG;
  final double fatsG;
  final double proteinGoalG;
  final double carbsGoalG;
  final double fatsGoalG;

  const DailyMacros({
    this.proteinG = 0,
    this.carbsG = 0,
    this.fatsG = 0,
    this.proteinGoalG = 120,
    this.carbsGoalG = 250,
    this.fatsGoalG = 70,
  });

  factory DailyMacros.fromJson(Map<String, dynamic> json) => DailyMacros(
        proteinG: (json['protein_g'] as num?)?.toDouble() ?? 0,
        carbsG: (json['carbs_g'] as num?)?.toDouble() ?? 0,
        fatsG: (json['fats_g'] as num?)?.toDouble() ?? 0,
        proteinGoalG: (json['protein_goal_g'] as num?)?.toDouble() ?? 120,
        carbsGoalG: (json['carbs_goal_g'] as num?)?.toDouble() ?? 250,
        fatsGoalG: (json['fats_goal_g'] as num?)?.toDouble() ?? 70,
      );

  double get proteinPct => proteinGoalG > 0 ? (proteinG / proteinGoalG).clamp(0, 1) : 0;
  double get carbsPct => carbsGoalG > 0 ? (carbsG / carbsGoalG).clamp(0, 1) : 0;
  double get fatsPct => fatsGoalG > 0 ? (fatsG / fatsGoalG).clamp(0, 1) : 0;
}