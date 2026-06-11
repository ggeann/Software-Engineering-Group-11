import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import 'UserDashboardpage.dart';
import 'food_nutrition_page1.dart';
import 'ActivityNHabit1.dart';
import 'ProgressnAnalyticpage1.dart';

enum PrimaryGoal { loseWeight, stayFit, buildMuscle }

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  PrimaryGoal? _option = PrimaryGoal.buildMuscle;
  int liter = 0;
  int steps = 0;

  void _navigateToPage(int index) {
    if (index == 4) return;

    Widget targetPage;
    switch (index) {
      case 0:
        targetPage = const Userdashboardpage();
        break;
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
        return;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FBF5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                'images/LifeTrack.png',
                height: 32,
                width: 32,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.person, color: Colors.white, size: 18),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'LifeTrack',
              style: TextStyle(
                color: Color(0xFF006B54),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
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
                    Container( // list #1
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
                                color: const Color(0xFF006C4D).withOpacity(0.12),
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
                                controlAffinity: ListTileControlAffinity.trailing,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container( // list #2
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
                                color: const Color(0xFF5B8FA8).withOpacity(0.12),
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
                                subtitle: Text("Maintain current health levels"),
                                value: PrimaryGoal.stayFit,
                                controlAffinity: ListTileControlAffinity.trailing,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container( // list #3
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
                                color: const Color(0xFF9C413F).withOpacity(0.12),
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
                                controlAffinity: ListTileControlAffinity.trailing,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Your Biometrics')
                    )
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
                    child: Text('Daily Targets')
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
        currentIndex: 4,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF006B54),
        unselectedItemColor: Colors.grey,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
