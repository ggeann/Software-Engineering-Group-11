import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:life_track/pages/Landingpage.dart' show Landingpage, Userdashboard;
import 'package:life_track/pages/food_nutrition_page1.dart'
    show FoodNNutritionPage1;
import 'package:life_track/pages/food_nutrition_page2.dart'
    show FoodNNutritionPage2;
import 'package:life_track/pages/food_nutrition_page3.dart'
    show FoodNNutritionPage3;
import 'package:life_track/models/meal_type.dart' show MealType;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',
    publishableKey: 'YOUR_SUPABASE_ANON_KEY',
  );

  runApp(const ProviderScope(child: LifeTrackApp()));
}

class LifeTrackApp extends StatelessWidget {
  const LifeTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D6E5C)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Landingpage(),
        '/food1': (context) => FoodNNutritionPage1(
          onNavigateToSearch: () => Navigator.pushNamed(
            context,
            '/food2',
            arguments: MealType.breakfast,
          ),
          onNavigateToHistory: () => Navigator.pushNamed(context, '/food3'),
        ),
        '/food2': (context) => FoodNNutritionPage2(
          targetMealType:
              ModalRoute.of(context)?.settings.arguments as MealType? ??
              MealType.breakfast,
        ),
        '/food3': (context) => const FoodNNutritionPage3(),
      },
    );
  }
}
