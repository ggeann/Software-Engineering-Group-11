# Plan: Food & Nutrition Module Implementation
**Based on:** `FoodNNutrition_PRD.md` v1.0.0

## Phase 0 — Dependencies
Add to `pubspec.yaml`: `flutter_riverpod`, `dio`, `fl_chart`, `hive_flutter`, `build_runner`, `intl`, `supabase_flutter`. Run `flutter pub get`.

## Phase 1 — Models & Theme
- `lib/models/` (6 files): `food_item.dart`, `meal_log.dart`, `daily_budget.dart`, `daily_summary.dart`, `daily_macros.dart`, `meal_type.dart`
- `lib/theme/` (3 files): `app_colors.dart`, `app_text_styles.dart`, `app_spacing.dart`

## Phase 2 — Services & Providers
- `lib/services/food_api_service.dart` — Dio client with all PRD S4.2 endpoints
- `lib/services/offline_cache_service.dart` — Hive cache with connection-error fallback
- `lib/providers/food_nutrition_providers.dart` — 9 Riverpod providers

## Phase 3 — Page 1 (Main Dashboard)
Refactor `food_log_page.dart` into `food_nutrition_page1.dart` (ConsumerWidget) + extracted widgets:
- `lib/widgets/food/`: `daily_budget_card.dart`, `macros_card.dart`, `donut_painter.dart`, `meal_section.dart`, `meal_section_header.dart`, `food_log_tile.dart`, `add_food_button.dart`, `log_final_meal_button.dart`, `food_search_bar.dart`
- `lib/widgets/common/`: `shimmer_loading.dart`, `error_view.dart`

## Phase 4 — Page 2 (Search & Detail)
- `lib/pages/food_nutrition_page2.dart` — search with 400ms debounce, filter chips, results, detail sheet
- `lib/widgets/food/`: `search_bar_widget.dart`, `filter_chips_row.dart`, `food_results_list.dart`, `recent_foods_list.dart`, `food_detail_sheet.dart`, `meal_type_dropdown.dart`, `calorie_badge.dart`, `nutrition_mini_bar.dart`, `serving_selector.dart`

## Phase 5 — Page 3 (History)
- `lib/pages/food_nutrition_page3.dart` — date strip, weekly bar chart, daily summaries, meal history
- `lib/widgets/food/`: `date_strip_selector.dart`, `weekly_calorie_bar_chart.dart`, `daily_summary_card.dart`, `history_log_tile.dart`, `history_meal_section.dart`, `edit_meal_log_sheet.dart`, `selected_date_header.dart`

## Phase 6 — Backend (Node.js + Express)
`backend/` with 13 endpoints per PRD S4.2:
- `app.js`, `config/supabase.js`, `middleware/auth.js`, `middleware/validate.js`
- `controllers/foodController.js`, `mealController.js`, `nutritionController.js`
- `routes/foodRoutes.js`, `mealRoutes.js`, `nutritionRoutes.js`
- `services/nutritionCalcService.js`

## Phase 7 — Routing & Integration
- `main.dart`: wrap with `ProviderScope`, add Supabase init, register `/food1` `/food2` `/food3` routes
- Fix `fontFamily: '"'"'Nunito'"'"'` (remove or declare font)

## Phase 8 — Database Schema
`supabase/schema.sql` — 4 tables (users_profile, food_items, meal_logs, daily_summaries) + triggers + RLS per PRD S3

## Summary
**~45 new files | 2 modified | 1 removed | Execution: 0-1-2-3-7-4-5-6-8**
