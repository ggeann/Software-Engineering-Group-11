import 'package:flutter/material.dart';
import 'package:life_track/pages/loginPage.dart';
// Import halaman User Dashboard sebagai tujuan akhir setelah Sign Up
import 'package:life_track/pages/userdashboardpage.dart'; 

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Controller untuk menangkap input data dari form pendaftaran
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fungsi Sign Up: Langsung menuju ke User Dashboard dan menghapus stack halaman lama
  void signUp() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Userdashboardpage()),
      (route) => false, // Menghapus tumpukan halaman lama agar tidak bisa kembali ke Sign Up
    );
  }

  // Membersihkan controller dari memori saat widget dihancurkan
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                children: [
                  _signupTitle(),
                  // Memasukkan controller ke masing-masing parameter form helper
                  _nameForm('Name', _nameController),
                  _emailForm('Email address', _emailController),
                  _passwordForm('Password', _passwordController),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 23,
                      right: 23,
                      top: 48,
                    ),
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
                          signUp();
                        },
                        child: const Text(
                          'Sign Up',
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
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5FBF5),
    );
  }

  Widget _signupTitle() {
    return Column(
      children: [
        const Text(
          'Sign Up', 
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Already have an account?'),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Log In'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _nameForm(String text, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 23, right: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 9),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              hintText: 'Name',
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

  Widget _emailForm(String text, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 23, right: 23, top: 23),
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
      padding: const EdgeInsets.only(left: 23, right: 23, top: 23),
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