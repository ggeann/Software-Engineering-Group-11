import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:life_track/pages/ProgressnAnalyticpage1.dart";
import "package:life_track/pages/ProgressnAnalyticpage2.dart";
import "package:life_track/pages/food_nutrition_page1.dart";
import "package:life_track/pages/userdashboardpage.dart" hide ActivityNHabitPage1;
import 'package:life_track/pages/ActivityNHabit1.dart';

enum PrimaryGoal { loseWeight, stayFit, buildMuscle }

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final int _currentNavIndex = 0;
  static const themeGreen = Color.fromARGB(255, 7, 100, 10);
  PrimaryGoal? _option = PrimaryGoal.buildMuscle;
  int liter = 0;
  int steps = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FBF5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text('LifeTrack'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_pin),
            iconSize: 40,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey.shade200,
                  child: ClipOval(
                    child: Image.network(
                      "https://plus.unsplash.com/premium_vector-1682269287900-d96e9a6c188b?q=80&w=580&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "John Doe",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            RadioGroup<PrimaryGoal>(
              groupValue: _option,
              onChanged: (PrimaryGoal? value) {
                setState(() {
                  _option = value;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      // list #1
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            // offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF006C4D,
                                ).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.monitor_weight,
                                color: const Color(0xFF006C4D),
                                size: 20,
                              ),
                            ),
                            Flexible(
                              child: RadioListTile<PrimaryGoal>(
                                title: Text("Lose Weight"),
                                subtitle: Text("Sustainable fat loss focus"),
                                value: PrimaryGoal.loseWeight,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      // list #2
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            // offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF5B8FA8,
                                ).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.fitness_center_rounded,
                                color: const Color(0xFF5B8FA8),
                                size: 20,
                              ),
                            ),
                            Flexible(
                              child: RadioListTile<PrimaryGoal>(
                                title: Text("Stay Fit"),
                                subtitle: Text(
                                  "Maintain current health levels",
                                ),
                                value: PrimaryGoal.stayFit,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      // list #3
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            // offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF9C413F,
                                ).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.bolt,
                                color: const Color(0xFF9C413F),
                                size: 20,
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<PrimaryGoal>(
                                title: Text("Lose Build Muscle"),
                                subtitle: Text("Strength & hyperthrophy"),
                                value: PrimaryGoal.buildMuscle,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Your Biometrics'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 28),
            Row(
              children: const [
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Age",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Height (cm)",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Weight (kg)",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Daily Targets'),
                  ),
                  SizedBox(height: 30),
                  Slider(
                    label: liter.toDouble().toString(),
                    value: liter.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        liter = value.toInt();
                      });
                    },
                    min: 0,
                    max: 6,
                  ),
                  SizedBox(height: 30),
                  Slider(
                    label: steps.toDouble().toString(),
                    value: steps.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        steps = value.toInt();
                      });
                    },
                    min: 0,
                    max: 6,
                  ),
                ],
              ),
            ),
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
