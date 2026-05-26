import 'package:flutter/material.dart';
import 'package:life_track/pages/signupPage.dart';
import 'UserDarboardpage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    const themeGreen = Color.fromARGB(255, 7, 100, 10);
    const themeBgLight = Color(
      0xFFF7FBF7,
    ); // Warna background agak putih kehijauan murni
    const themeGreyCard = Color(0xFFEAEAEA); // Abu-abu muda untuk card fitur

    return Scaffold(
      backgroundColor: themeBgLight,
      appBar: AppBar(
        backgroundColor: themeBgLight,
        elevation: 0.0,
        toolbarHeight: 70,
        title: Row(
          children: [
            // Logo Kotak Hitam Lifetrack
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5),
              ),
              child: ClipRRect(
                borderRadius:BorderRadius.circular(5),
                child:Image.asset(
                  'images/LifeTrack.png',
                  fit:BoxFit.cover,
                )
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'LifeTrack',
              style: TextStyle(
                color: themeGreen,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          // Tombol Sign In yang akan mengarah ke Dashboard
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 15, bottom: 15),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignupPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: themeGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SECTION 1: HERO IMAGE WITH OVERLAY TEXT
            Stack(
              children: [
                // Gambar utama latar belakang
                Container(
                  height: 450,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      // Menggunakan gambar placeholder berkualitas tinggi bertema makanan sehat & fitness
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1490645935967-10de6ba17061?q=80&w=600',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 450,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.white.withOpacity(0.8),
                        themeBgLight,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your health,\nPerfectly Tracked',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'The science-backed way to balance your nutrition, movements, and hydration in one serene interface.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            // SECTION 2: FITUR CARDS (Food, Activity, Hydration)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildFeatureCard(
                    'Food',
                    'Log your meals and track daily macros.',
                    Icons.restaurant,
                    themeGreyCard,
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureCard(
                    'Activity',
                    'Record your workouts and active minutes.',
                    Icons.directions_run,
                    themeGreyCard,
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureCard(
                    'Hydration',
                    'Track your water intake and stay refreshed.',
                    Icons.water_drop,
                    themeGreyCard,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // SECTION 3: VISUAL CLARITY BANNER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Visual Clarity in\nEvery Metric',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'With our minimalism design we ensures you to see what matters most at a single glance',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFFB2DFDB,
                        ), // Warna hijau toska pastel seperti mockup gambar
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Container(
                          width: 140,
                          height: 250,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Ilustrasi Ring chart sederhana di dalam HP mockup
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: themeGreen,
                                    width: 8,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                '00%',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget untuk membuat 3 buah Kartu Fitur secara modular dan rapi
  Widget _buildFeatureCard(
    String title,
    String subtitle,
    IconData icon,
    Color bgColor,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
          Icon(
            icon,
            color: const Color.fromARGB(255, 7, 100, 10).withOpacity(0.6),
            size: 28,
          ),
        ],
      ),
    );
  }
}
