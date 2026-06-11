import 'package:flutter/material.dart';
import 'package:life_track/pages/signupPage.dart';
// Import halaman User Dashboard sebagai tujuan akhir setelah Log In
import 'package:life_track/pages/userdashboardpage.dart'; 

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controller untuk menangkap input data email dan password log in
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fungsi Sign In: Langsung menuju ke User Dashboard dan menghapus stack halaman lama
  void signIn() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Userdashboardpage()),
      (route) => false, // Menghapus tumpukan halaman lama agar tidak bisa kembali ke Log In
    );
  }

  // Membersihkan controller dari memori saat widget dihancurkan
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white, // Perbaikan kode hex warna
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 11,
                spreadRadius: 6,
              ),
            ],
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0.3),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(100)),
                      child: Image(
                        image: const AssetImage('images/LifeTrack.png'),
                        height: 121,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback icon jika aset gambar belum terdeteksi/dimasukkan di pubspec.yaml
                          return const Icon(Icons.spa, size: 80, color: Color(0xFF3EB489));
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 13),
                  const Text(
                    'Login to your account.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Column(
                    children: [
                      // Memasukkan controller ke parameter fungsi form helper
                      _emailForm('Email address', _emailController),
                      _passwordForm('Password', _passwordController),
                      Padding(
                        padding: const EdgeInsets.only(left: 23, right: 23, top: 32),
                        child: SizedBox(
                          height: 56,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3EB489), // Perbaikan kode warna 8-digit hex
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              signIn();
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignupPage()),
                          );
                        },
                        child: const Text('Sign up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5FBF5),
    );
  }

  Widget _emailForm(String text, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 23, right: 23, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 9),
          TextField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              filled: true,
              hintText: 'name@example.com',
              fillColor: const Color(0xFFF5FBF5),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.black12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Color(0xFF3EB489), width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _passwordForm(String text, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 23, right: 23, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 9),
          TextField(
            controller: controller,
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF5FBF5),
              hintText: 'Enter password',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.black12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Color(0xFF3EB489), width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}