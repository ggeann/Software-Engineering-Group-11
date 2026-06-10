import 'package:flutter/material.dart';

class ActivityNHabitPage3 extends StatefulWidget {
  const ActivityNHabitPage3({super.key});

  @override
  State<ActivityNHabitPage3> createState() => _ActivityNHabitPage3State();
}

class _ActivityNHabitPage3State extends State<ActivityNHabitPage3> {
  // Controller untuk menangkap teks yang diketik user
  final TextEditingController _habitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F8F5), // Background hijau pucat
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER LIFETRACK ---
              Row(
                children: [
                  Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Center(
                      child: Icon(Icons.forest, color: Colors.greenAccent, size: 30),
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
              const SizedBox(height: 40),

              // --- TITLE ---
              const Text(
                'Habit Planner',
                style: TextStyle(
                  fontSize: 32, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              // --- INPUT CONTAINER (Gray Box) ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8E5), // Abu-abu box
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  children: [
                    // Row Input 1
                    _buildInputRow(_habitController),
                    const SizedBox(height: 15),
                    
                    // Row Input 2 (Placeholder sesuai figma)
                    _buildInputRow(null), 
                    
                    const SizedBox(height: 25),

                    // --- TOMBOL SET YOUR HABIT (Dashed style placeholder) ---
                    GestureDetector(
                      onTap: () {
                        if (_habitController.text.isNotEmpty) {
                          // Kirim teks habit kembali ke Page 1
                          Navigator.pop(context, _habitController.text);
                        } else {
                          // Jika kosong, sekedar kembali
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.2), 
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, size: 18, color: Colors.black.withOpacity(0.5)),
                            const SizedBox(width: 8),
                            Text(
                              'Set your habit',
                              style: TextStyle(
                                fontSize: 16,
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
    );
  }

  // Widget helper untuk membuat baris input putih sesuai Figma
  Widget _buildInputRow(TextEditingController? controller) {
    return Row(
      children: [
        // Kotak Input Putih
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
            child: TextField(
              controller: controller,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
        const SizedBox(width: 15),
        // Kotak Checklist Putih di kanan
        Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}