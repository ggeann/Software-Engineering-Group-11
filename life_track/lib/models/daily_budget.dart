class MacroDetail {
  final double consumedG;
  final double goalG;
  final double percentage;

  const MacroDetail({
    required this.consumedG,
    required this.goalG,
    this.percentage = 0,
  });

  factory MacroDetail.fromJson(Map<String, dynamic> json) => MacroDetail(
        consumedG: (json['consumed_g'] as num).toDouble(),
        goalG: (json['goal_g'] as num).toDouble(),
        percentage: (json['percentage'] as num?)?.toDouble() ?? 0,
      );
}

class DailyBudget {
  final String date;
  final double goalKcal;
  final double consumedKcal;
  final double remainingKcal;
  final double percentageUsed;
  final Map<String, MacroDetail> macros;

  const DailyBudget({
    required this.date,
    required this.goalKcal,
    required this.consumedKcal,
    required this.remainingKcal,
    this.percentageUsed = 0,
    this.macros = const {},
  });

  factory DailyBudget.fromJson(Map<String, dynamic> json) {
    final rawMacros = json['macros'] as Map<String, dynamic>?;
    return DailyBudget(
      date: json['date'] as String,
      goalKcal: (json['goal_kcal'] as num).toDouble(),
      consumedKcal: (json['consumed_kcal'] as num).toDouble(),
      remainingKcal: (json['remaining_kcal'] as num).toDouble(),
      percentageUsed: (json['percentage_used'] as num?)?.toDouble() ?? 0,
      macros: rawMacros?.map((k, v) => MapEntry(k, MacroDetail.fromJson(v as Map<String, dynamic>))) ??
          {},
    );
  }
}