import 'package:flutter/material.dart';
import 'package:life_track/pages/profile.dart';
// import 'FoodNNutritionpage.dart';
// import 'ActivityNHabitpage.dart';
import 'ProgressnAnalyticpage1.dart';

class UserDashboardpage extends StatefulWidget {
  const UserDashboardpage({super.key});

  @override
  State<UserDashboardpage> createState() => _UserDashboardpageState();
}

class _UserDashboardpageState extends State<UserDashboardpage> {
  // Menjaga status halaman aktif (0 = Dashboard utama)
  int _currentIndex = 0;

  // 2. Daftarkan semua halaman ke dalam sebuah List widget
  final List<Widget> _pages = [
    const DashboardMainContent(), // Isi konten utama dashboard dipindah ke widget bawah
    // const Food(), // Halaman Food & Nutrition yang baru dibuat
    // const ActivityNHabitpage(), // Halaman Activity & Habit placeholder
    const Progressnanalyticpage1(), // Halaman Progress & Analytic placeholder
    const Profile(), // Halaman Profile
  ];

  @override
  Widget build(BuildContext context) {
    const themeGreen = Color.fromARGB(255, 7, 100, 10);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        toolbarHeight: 80,
        title: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(Icons.favorite, color: themeGreen, size: 24),
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
      
      // === PERBAIKAN BODY ===
      // Menggunakan _pages agar halaman berubah secara dinamis saat BottomNavigationBar diklik
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: themeGreen,
        unselectedItemColor: Colors.grey,
        // 4. Hubungkan index aktif dan fungsi tap tombol navigasi
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index; // Mengubah halaman aktif saat ditekan
          });
        },
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
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  } // Tanda kurung build yang sempat hilang sudah ditambahkan di sini
}

// === WIDGET BARU: KONTEN UTAMA DASHBOARD ===
// Memindahkan isi body dashboard lama ke sini agar struktur kode bottom navbar bekerja sempurna
class DashboardMainContent extends StatelessWidget {
  const DashboardMainContent({super.key});

  @override
  Widget build(BuildContext context) {
    const themeGreen = Color.fromARGB(255, 7, 100, 10);
    const themeGreyCard = Color(0xFFE0E0E0);
    const themeGreenCard = Color(0xFFC8E6C9);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text(
            'Hello , John',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            'Ready for your morning check-in?',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 25),

          // CARD CALORIES
          Container(
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
          const SizedBox(height: 20),

          // ROW WATER & STEPS
          Row(
            children: [
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
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
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
                        style: TextStyle(fontSize: 11, color: Colors.black87),
                      ),
                      const Text(
                        '07:20 AM',
                        style: TextStyle(fontSize: 11, color: Colors.black54),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
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
            ],
          ),
          const SizedBox(height: 25),

          // WEEKLY MILESTONE
          Container(
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}