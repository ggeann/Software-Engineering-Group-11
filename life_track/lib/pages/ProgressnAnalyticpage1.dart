import 'package:flutter/material.dart';
import 'package:life_track/pages/ProgressnAnalyticpage2.dart';
// import 'package:flutter_application_1/ProgressnAnalyticpage1.dart';
// import 'package:flutter_application_1/ProgressnAnalyticpage2.dart';

class Progressnanalyticpage1 extends StatefulWidget {
  const Progressnanalyticpage1({super.key});

  @override
  _Progressnanalyticpage1State createState() => _Progressnanalyticpage1State();
}

class _Progressnanalyticpage1State extends State<Progressnanalyticpage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                "LT",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              "LifeTrack",
              style: TextStyle(
                color: Color(0xFF115D52),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Monthly Analytics",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const Text(
              "Your Progress",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // Health Score Card
            _buildMetricCard(
              title: "Health Score",
              value: "84",
              subtext: "Avg. 84 (+4% vs last month)",
              chipText: "30 Days",
              bars: [0.65, 0.85, 0.80],
              labels: ["May 1", "May 15", "Today"],
            ),

            const SizedBox(height: 15),

            // Body Weight Card
            _buildMetricCard(
              title: "Body Weight",
              value: "72.4 kg",
              subtext: "72.4 kg (-1.2 kg trend)",
              chipText: "Stable",
              chipColor: Colors.blue.withValues(alpha: 0.1),
              bars: [0.75, 0.65, 0.55],
              labels: ["74kg", "73,5kg", "72kg"],
              barColor: const Color(0xFF3A6073),
            ),

            const SizedBox(height: 15),

            // Row untuk Calorie Balance dan Active Min
            Row(
              children: [
                Expanded(
                  child: _buildSmallStatCard(
                    title: "Calorie Balance",
                    value: "1,950",
                    unit: "kcal",
                    icon: Icons.restaurant,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSmallStatCard(
                    title: "Active min",
                    value: "354",
                    unit: "min",
                    icon: Icons.fitness_center,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // Habit Consistency Mini Dashboard Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFE5EAE5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Habit Consistency",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Mini Preview Grid (2 baris x 10 kolom dummy streak)
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: List.generate(21, (index) {
                      return Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: const Color(0xFF38B2AC),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "20-day streak!!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ProgressnAnalyticpage2(),
                            ),
                          );
                        },
                        child: Row(
                          children: const [
                            Text(
                              "View detail",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 14,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            _buildFooterFooter(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtext,
    required String chipText,
    required List<double> bars,
    required List<String> labels,
    Color chipColor = const Color(0xFFE0F2F1),
    Color barColor = const Color(0xFF115D52),
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: chipColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  chipText,
                  style: const TextStyle(
                    color: Color(0xFF115D52),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          Text(
            subtext,
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(bars.length, (index) {
              return Column(
                children: [
                  Container(
                    width: 14,
                    height: 120 * bars[index],
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    labels[index],
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallStatCard({
    required String title,
    required String value,
    required String unit,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE5EAE5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Icon(icon, size: 16, color: const Color(0xFF115D52)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            // Menggunakan crossAxisAlignment baseline agar satuan teks berada sejajar di bawah angka
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                unit,
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFFD3DDD3),
      selectedItemColor: const Color(0xFF115D52),
      unselectedItemColor: Colors.black,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex:
          3, // Mengaktifkan tab analitik/grafik sesuai figma (ikon hijau melingkar)
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.food_bank_sharp),
          label: 'Nutrition',
        ),
        BottomNavigationBarItem(  
          icon: Icon(Icons.sports_gymnastics_rounded),
          label: "Activity",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Progress'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }

  Widget _buildFooterFooter() {
    return Column(
      children: [
        const Center(
          child: Text(
            "LifeTrack",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF115D52),
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "© 2024 LifeTrack Wellness. Optimistic health for a better you.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Privacy", style: TextStyle(fontSize: 11, color: Colors.grey)),
            SizedBox(width: 12),
            Text("Terms", style: TextStyle(fontSize: 11, color: Colors.grey)),
            SizedBox(width: 12),
            Text("Support", style: TextStyle(fontSize: 11, color: Colors.grey)),
            SizedBox(width: 12),
            Text("Blog", style: TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}
