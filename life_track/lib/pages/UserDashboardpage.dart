import 'package:flutter/material.dart';

class Userdashboardpage extends StatelessWidget {
  const Userdashboardpage({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna tema
    const themeGreen = Color.fromARGB(255, 7, 100, 10);
    const themeGreyCard = Color(0xFFE0E0E0); // Abu-abu muda untuk card
    const themeGreenCard = Color(0xFFC8E6C9); // Hijau muda untuk milestone

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        toolbarHeight: 80, // Sedikit lebih tinggi untuk menampung logo
        title: Row(
          children: [
            // Container untuk simulasi Logo di gambar
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.black, // Background logo hitam
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
      body: SingleChildScrollView(
        // Agar bisa di-scroll jika layar penuh
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // GREETING
            const Text(
              'Hello , John',
              style: TextStyle(
                fontSize: 32, // Ukuran besar seperti gambar
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Ready for your morning check-in?',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 25),

            // CARD CALORIES (Sekarang menggunakan Column untuk rincian)
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
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '1,850 / 2,200 kcal',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // PROGRESS BAR
                  const LinearProgressIndicator(
                    value: 1.85 / 2.2, // Persentase progress
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
                // WATER CARD
                Expanded(
                  child: Container(
                    height: 120, // Sedikit lebih tinggi untuk menampung teks
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
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Icon(Icons.add, color: themeGreen, size: 30),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            '5/10 glasses',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Jarak horizontal
                // STEPS CARD
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
                              fontSize: 16, fontWeight: FontWeight.bold),
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
                                  horizontal: 20, vertical: 5),
                              minimumSize: Size.zero, // Mengecilkan tombol
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

            // WEEKLY MILESTONE (Sekarang menggunakan Column untuk detail)
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
                    'Your 10x more active then last week!!',
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
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
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
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
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