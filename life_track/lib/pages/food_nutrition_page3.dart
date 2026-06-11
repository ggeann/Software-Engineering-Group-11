import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal_log.dart';
import '../models/meal_type.dart';
import '../providers/food_nutrition_providers.dart';
import '../widgets/food/date_strip_selector.dart';
import '../widgets/food/selected_date_header.dart';
import '../widgets/food/weekly_calorie_bar_chart.dart';
import '../widgets/food/daily_summary_card.dart';
import '../widgets/food/history_meal_section.dart';
import '../widgets/common/shimmer_loading.dart';
import '../widgets/common/error_view.dart';

class FoodNNutritionPage3 extends ConsumerStatefulWidget {
  const FoodNNutritionPage3({super.key});

  @override
  ConsumerState<FoodNNutritionPage3> createState() => _FoodNNutritionPage3State();
}

class _FoodNNutritionPage3State extends ConsumerState<FoodNNutritionPage3> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(historyMealLogsProvider(_selectedDate));
    final weeklyAsync = ref.watch(weeklySummariesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: _pickDate,
          ),
        ],
      ),
      body: Column(
        children: [
          DateStripSelector(
            selectedDate: _selectedDate,
            onDateSelected: (d) => setState(() => _selectedDate = d),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(historyMealLogsProvider(_selectedDate));
                ref.invalidate(weeklySummariesProvider);
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectedDateHeader(date: _selectedDate),
                    weeklyAsync.when(
                      data: (summaries) => WeeklyCalorieBarChart(
                        weeklySummaries: summaries,
                        goal: 2100,
                      ),
                      loading: () => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: ShimmerLoading(height: 160, borderRadius: 16),
                      ),
                      error: (_, _) => const SizedBox.shrink(),
                    ),
                    historyAsync.when(
                      data: (logs) => _buildHistoryContent(logs),
                      loading: () => const Padding(
                        padding: EdgeInsets.all(16),
                        child: ShimmerLoading(height: 200, borderRadius: 16),
                      ),
                      error: (e, _) => ErrorView(message: e.toString()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryContent(List<MealLog> logs) {
    final totalCalories = logs.fold<double>(0, (s, l) => s + l.calories);
    return Column(
      children: [
        DailySummaryCard(
          totalCalories: totalCalories,
          goalCalories: 2100,
          proteinG: logs.fold<double>(0, (s, l) => s + l.proteinG),
          carbsG: logs.fold<double>(0, (s, l) => s + l.carbsG),
          fatsG: logs.fold<double>(0, (s, l) => s + l.fatsG),
        ),
        HistoryMealSection(
          mealType: MealType.breakfast,
          logs: logs.where((l) => l.mealType == MealType.breakfast).toList(),
        ),
        HistoryMealSection(
          mealType: MealType.lunch,
          logs: logs.where((l) => l.mealType == MealType.lunch).toList(),
        ),
        HistoryMealSection(
          mealType: MealType.dinner,
          logs: logs.where((l) => l.mealType == MealType.dinner).toList(),
        ),
        HistoryMealSection(
          mealType: MealType.snack,
          logs: logs.where((l) => l.mealType == MealType.snack).toList(),
        ),
        const SizedBox(height: 80),
      ],
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }
}