import 'package:flutter/material.dart';
import 'package:life_track/pages/ActivityNHabit1.dart';
import 'package:life_track/pages/UserDashboardpage.dart';
// hide ActivityNHabitPage1;
import 'package:life_track/pages/food_nutrition_page1.dart';
import 'package:life_track/pages/profile.dart';

class ProgressnAnalyticpage2 extends StatefulWidget {
  const ProgressnAnalyticpage2({Key? key}) : super(key: key);

  @override
  _ProgressnAnalyticpage2State createState() => _ProgressnAnalyticpage2State();
}

class _ProgressnAnalyticpage2State extends State<ProgressnAnalyticpage2> {
  // Grid data (28 hari), true berarti habit selesai (hijau)
  final int _currentNavIndex = 0;

  static const themeGreen = Color.fromARGB(255, 7, 100, 10);
  List<bool> habitStatus = List.generate(28, (index) => index < 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF8C9D8C,
      ), // Background olive sesuai Figma Anda
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // Tombol back jadi putih
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header Logo
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        "LT",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "LifeTrack",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Habit Consistency",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 15),

                // Grid Heatmap Interaktif
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: habitStatus.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          habitStatus[index] = !habitStatus[index];
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: habitStatus[index]
                              ? const Color(0xFF115D52)
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),

                // Footer Branding
                const Text(
                  "LifeTrack",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF115D52),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "© 2026 LifeTrack Wellness. Optimistic health for a better YOU.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Privacy",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Terms",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Support",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Blog",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
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

  void _navigateToPage(int index) {
    if (index == _currentNavIndex) return;

    Widget targetPage;

    switch (index) {
      case 0:
        targetPage = const Userdashboardpage();
      case 1:
        targetPage = const FoodNNutritionPage1();
        break;
      case 2:
        targetPage = const ActivityNHabitPage1();
        break;
      case 3:
        return;
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
