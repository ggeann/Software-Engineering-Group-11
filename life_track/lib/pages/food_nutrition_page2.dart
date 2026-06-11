import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import '../models/food_item.dart';
import '../models/meal_type.dart';
import '../providers/food_nutrition_providers.dart';
import '../widgets/food/search_bar_widget.dart';
import '../widgets/food/food_results_list.dart';
import '../widgets/food/food_detail_sheet.dart';
import '../widgets/food/meal_type_dropdown.dart';
import '../widgets/common/error_view.dart';

class FoodNNutritionPage2 extends ConsumerStatefulWidget {
  final MealType targetMealType;

  const FoodNNutritionPage2({
    super.key,
    this.targetMealType = MealType.breakfast,
  });

  @override
  ConsumerState<FoodNNutritionPage2> createState() => _FoodNNutritionPage2State();
}

class _FoodNNutritionPage2State extends ConsumerState<FoodNNutritionPage2> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String _query = '';
  MealType _selectedType = MealType.breakfast;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.targetMealType;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() => _query = _searchController.text.trim());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(foodSearchProvider(_query));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: MealTypeDropdown(
          selected: _selectedType,
          onChanged: (type) => setState(() => _selectedType = type),
        ),
      ),
      body: Column(
        children: [
          SearchBarWidget(
            controller: _searchController,
            onClear: () => setState(() => _query = ''),
          ),
          _buildFilterChips(),
          const Divider(height: 1),
          Expanded(
            child: searchResults.when(
              data: (foods) => _query.isEmpty
                  ? _buildRecentFoods()
                  : FoodResultsList(foods: foods, onTap: _showFoodDetail),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => ErrorView(message: e.toString()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _chip(Icons.camera_alt_outlined, 'QuickScan', () {}),
          const SizedBox(width: 8),
          _chip(Icons.history, 'Recents', () {}),
          const SizedBox(width: 8),
          _chip(Icons.favorite_outline, 'Favorites', () {}),
        ],
      ),
    );
  }

  Widget _chip(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: const Color(0xFF6B7280)),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentFoods() {
    final recent = ref.watch(recentFoodsProvider);
    return recent.when(
      data: (foods) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text('Recent', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF6B7280))),
          ),
          FoodResultsList(foods: foods, onTap: _showFoodDetail),
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => ErrorView(message: e.toString()),
    );
  }

  void _showFoodDetail(dynamic foodItem) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => FoodDetailSheet(
        food: foodItem as FoodItem,
        targetMealType: _selectedType,
      ),
    );
  }
}