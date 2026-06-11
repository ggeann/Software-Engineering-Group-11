import 'package:flutter/material.dart';
import 'package:life_track/pages/signupPage.dart';
// TODO: Jangan lupa import file signup_page kamu di sini, contoh:
// import 'package:life_track/pages/signup_page.dart'; 

class Landingpage extends StatelessWidget {
  const Landingpage({super.key});

  @override
  Widget build(BuildContext context) {
    // Palet warna minimalis sesuai gambar Figma
    const themeGreen = Color(0xFF005F43); 
    const themeBgLight = Color(0xFFF7FBF7); 
    const themeGreyCard = Color(0xFFE9EBE9); 
    const tealPastel = Color(0xFF9EDCD0);

    return Scaffold(
      backgroundColor: themeBgLight,
      // 1. APPBAR (Hanya Logo & Tombol Sign In)
      appBar: AppBar(
        backgroundColor: themeBgLight,
        elevation: 0.0,
        scrolledUnderElevation: 0,
        toolbarHeight: 70,
        titleSpacing: 20,
        title: Row(
          children: [
            // Logo Kotak Hitam Minimalis Lifetrack
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.spa, color: Color(0xFF81C784), size: 18),
            ),
            const SizedBox(width: 10),
            const Text(
              'LifeTrack',
              style: TextStyle(
                color: themeGreen,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        actions: [
          // === PERBAIKAN NAVIGASI DI SINI ===
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SizedBox(
              height: 36,
              child: ElevatedButton(
                onPressed: () {
                  // Berpindah ke halaman SignupPage saat tombol ditekan
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupPage(), // Sesuaikan dengan nama class SignUp milikmu
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeGreen,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
            ),
          ),
        ],
      ),

      // 2. BODY UTAMA LANDING PAGE
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HERO SECTION (Gambar Makanan & Teks Utama)
            Stack(
              children: [
                Container(
                  height: 460,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1490645935967-10de6ba17061?q=80&w=600',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 460,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.01),
                        themeBgLight.withOpacity(0.4),
                        themeBgLight,
                      ],
                      stops: const [0.0, 0.7, 1.0],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 15,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            height: 1.15,
                            letterSpacing: -1,
                          ),
                          children: [
                            TextSpan(text: 'Your health,\n'),
                            TextSpan(
                              text: 'Perfectly Tracked',
                              style: TextStyle(color: themeGreen),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'The science-backed way to balance your nutrition, movements, and hydration in one serene interface',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // FEATURE CARDS SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildFeatureCard(
                    'Food',
                    'Log your meals and track daily macros.',
                    themeGreyCard,
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureCard(
                    'Activity',
                    'Record your workouts and active minutes.',
                    themeGreyCard,
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureCard(
                    'Hydration',
                    'Track your water intake and stay refreshed.',
                    themeGreyCard,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 45),

            // VISUAL CLARITY SECTION & MOCKUP HP TOSKA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Visual Clarity in\nEvery Metric',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      height: 1.15,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'With our minimalism design we ensures you to see what matters most at a single glance',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Kotak Toska Latar Belakang Mockup HP
                  Container(
                    width: double.infinity,
                    height: 320,
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    decoration: BoxDecoration(
                      color: tealPastel, 
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Container(
                        width: 155,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('LifeTrack', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.black38)),
                                  Icon(Icons.circle, size: 8, color: Colors.black26),
                                ],
                              ),
                              const Spacer(),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 85,
                                    height: 85,
                                    child: CircularProgressIndicator(
                                      value: 0.65,
                                      strokeWidth: 10,
                                      backgroundColor: const Color(0xFFE0F2F1),
                                      color: const Color(0xFF4DB6AC),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                height: 12,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.black12, 
                                  borderRadius: BorderRadius.circular(4),
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

  // Komponen Card Fitur Kotak
  Widget _buildFeatureCard(String title, String subtitle, Color bgColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}