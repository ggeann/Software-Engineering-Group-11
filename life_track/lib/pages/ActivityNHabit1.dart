import 'package:flutter/material.dart';
// Pastikan path import ini sesuai dengan struktur project kamu
import 'ActivityNHabit2.dart';
import 'ActivityNHabit3.dart'; // 1. IMPORT PAGE 3 DI SINI

class ActivityNHabitPage1 extends StatefulWidget {
  const ActivityNHabitPage1({super.key});

  @override
  State<ActivityNHabitPage1> createState() => _ActivityNHabitPage1State();
}

class _ActivityNHabitPage1State extends State<ActivityNHabitPage1> {
  // Menampung daftar aktivitas yang di-log secara dinamis.
  final List<Map<String, dynamic>> _loggedActivities = [
    {
      'title': 'Running',
      'subtitle': 'Morning-45min',
      'calories': '+300kcal',
      'time': '07:20am',
    },
    {
      'title': 'Swimming',
      'subtitle': 'Evening-45min',
      'calories': '+250kcal',
      'time': '',
    },
  ];

  // Fungsi navigasi ke Page 2
  Future<void> _navigateAndLogActivity(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ActivityNHabitPage2()),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _loggedActivities.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F8F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 1. HEADER APP ---
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.forest,
                        color: Colors.greenAccent,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'LifeTrack',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F5A47),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // --- 2. DAILY ACTIVITY SUMMARY CARD ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8E5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Daily Activity',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              '1,950',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                'kcal',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildBarChart(35),
                        const SizedBox(width: 6),
                        _buildBarChart(50),
                        const SizedBox(width: 6),
                        _buildBarChart(65),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // --- 3. DYNAMIC ACTIVITY LIST ---
              Column(
                children: _loggedActivities.map((activity) {
                  return _buildActivityCard(activity);
                }).toList(),
              ),

              // --- 4. BUTTON: LOG YOUR ACTIVITY ---
              GestureDetector(
                onTap: () => _navigateAndLogActivity(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E8E5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.black.withOpacity(0.4),
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Log your activity',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // --- 5. HABIT PLANNER SECTION ---
              const Text(
                'Habit Planner',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8E5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  children: [
                    _buildHabitRow('Sleep 8 hours'),
                    const SizedBox(height: 12),
                    _buildHabitRow('Drink 1L'),
                    const SizedBox(height: 20),

                    // --- REPARASI DI SINI: BUTTON "Set your habit" SEKARANG BISA DI-KLIK ---
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ActivityNHabitPage3(), // Menuju Page 3
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors
                              .transparent, // Membuat area dalam card tetap clean
                          border: Border.all(
                            color: Colors.black.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 16,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Set your habit',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // --- 6. BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFD6DDD8),
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.grid_view, size: 28, color: Colors.black),
              const Icon(Icons.restaurant, size: 28, color: Colors.black),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFF0F5A47),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.fitness_center,
                  size: 28,
                  color: Colors.white,
                ),
              ),
              const Icon(Icons.bar_chart, size: 28, color: Colors.black),
              const Icon(Icons.person, size: 28, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBarChart(double height) {
    return Container(
      width: 14,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF0F5A47),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildHabitRow(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Container(width: 18, height: 18, color: const Color(0xFF4AC398)),
      ],
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity) {
    final String timeDisplay =
        (activity['time'] != null && activity['time'].toString().isNotEmpty)
        ? activity['time']
        : '--:--';

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8E5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  activity['title'] ?? 'Unknown Activity',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                activity['calories'] ?? '0 kcal',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  activity['subtitle'] ?? '',
                  style: const TextStyle(fontSize: 18, color: Colors.black87),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                timeDisplay,
                style: const TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
