import 'package:flutter/material.dart';
import 'package:life_track/pages/ProgressnAnalyticpage2.dart';
import 'package:life_track/pages/ProgressnAnalyticpage1.dart';

import 'food_nutrition_page1.dart';
import 'ActivityNHabit1.dart';
import 'package:life_track/pages/ActivityNHabit1.dart';

import 'ProgressnAnalyticpage1.dart';
import 'profile.dart';

class Userdashboardpage extends StatefulWidget {
  const Userdashboardpage({super.key});

  @override
  State<Userdashboardpage> createState() => _UserdashboardpageState();
}

class _UserdashboardpageState extends State<Userdashboardpage> {
  // Indeks 0 menandakan halaman aktif saat ini adalah Dashboard
  final int _currentNavIndex = 0;

  // Warna tema aplikasi LifeTrack
  static const themeGreen = Color.fromARGB(255, 7, 100, 10);
  static const themeGreyCard = Color(0xFFE0E0E0);
  static const themeGreenCard = Color(0xFFC8E6C9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        toolbarHeight: 80,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'images/LifeTrack.png',
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Icon(
                    Icons.broken_image,
                    color: themeGreen,
                    size: 24,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            const Text(
              'LifeTrack',
              style: TextStyle(
                color: themeGreen,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // GREETING
            const Text(
              'Hello, John',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'Ready for your morning check-in?',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 25),

            // CARD CALORIES -> Menuju ke Food & Nutrition Page
            GestureDetector(
              onTap: () => _navigateToPage(1),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: themeGreyCard,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Calories',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '1,850 / 2,200 kcal',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const LinearProgressIndicator(
                      value: 1.85 / 2.2,
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(themeGreen),
                      minHeight: 10,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('In: 1,850 kcal', style: TextStyle(fontSize: 12)),
                        Text('Out: 420 kcal', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ROW WATER & STEPS
            Row(
              children: [
                // WATER CARD
                Expanded(
                  child: Container(
                    height: 120,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: themeGreyCard,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Water',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Icon(Icons.add, color: themeGreen, size: 30),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            '5/10 glasses',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // STEPS CARD -> Menuju ke Activity & Habit Page
                Expanded(
                  child: GestureDetector(
                    onTap: () => _navigateToPage(2),
                    child: Container(
                      height: 120,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: themeGreyCard,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Steps',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Morning run session',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black87,
                            ),
                          ),
                          const Text(
                            '07:20 AM',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: ElevatedButton(
                              onPressed: () => _navigateToPage(2),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: themeGreen,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5,
                                ),
                                minimumSize: Size.zero,
                              ),
                              child: const Text('Start'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // WEEKLY MILESTONE -> Menuju ke Progress & Analytic Page
            GestureDetector(
              onTap: () => _navigateToPage(3),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: themeGreenCard,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Weekly Milestone',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Your 10x more active than last week!!',
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'View detail ->',
                        style: TextStyle(
                          fontSize: 12,
                          color: themeGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: themeGreen,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentNavIndex,
        onTap: (index) => _navigateToPage(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank_rounded),
            label: 'Nutrition',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_gymnastics_rounded),
            label: "Activity",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // JALUR NAVIGASI UTAMA KE SEMUA PAGE
  void _navigateToPage(int index) {
    if (index == _currentNavIndex) return;
  
    Widget targetPage;

    switch (index) {
      case 0:
        return; // Sudah di Dashboard
      case 1:
        targetPage = const FoodNNutritionPage1();
        break;
      case 2:
        targetPage = const ActivityNHabitPage1();
        break;
      case 3:
        targetPage = const Progressnanalyticpage1();
        break;
      case 4:
        targetPage = const Profile();
        break;
      default:
        return;
    }

    // Pindah halaman dengan menghapus halaman lama dari tumpukan (stack)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }
}

// =========================================================================
// PLACEHOLDER CLASSES
// Hapus atau beri komentar pada class di bawah ini jika kamu sudah membuat
// file aslinya dan meng-import-nya di bagian atas file ini.
// =========================================================================

// class ActivityNHabitPage1 extends StatelessWidget {
//   const ActivityNHabitPage1({super.key});
//   @override
//   Widget build(BuildContext context) =>
//       const Scaffold(body: Center(child: Text('Activity & Habit Page 1')));
// }

// class ProgressNAnalyticPage1 extends StatelessWidget {
//   const ProgressNAnalyticPage1({super.key});
//   @override
//   Widget build(BuildContext context) =>
//       const Scaffold(body: Center(child: Text('Progress & Analytic Page 1')));
// }

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});
//   @override
//   Widget build(BuildContext context) =>
//       const Scaffold(body: Center(child: Text('Profile Page')));
// }
