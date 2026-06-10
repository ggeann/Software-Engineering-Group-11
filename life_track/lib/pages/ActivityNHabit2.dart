import 'package:flutter/material.dart';

class ActivityNHabitPage2 extends StatefulWidget {
  const ActivityNHabitPage2({super.key});

  @override
  State<ActivityNHabitPage2> createState() => _ActivityNHabitPage2State();
}

class _ActivityNHabitPage2State extends State<ActivityNHabitPage2> {
  // State untuk menyimpan aktivitas mana yang sedang dipilih/diklik oleh user
  Map<String, dynamic>? _selectedActivity;

  final List<Map<String, dynamic>> _activities = [
    {
      'title': 'Jogging',
      'subtitle': 'Evening-45min',
      'calories': '+300kcal',
      'time': '07:20am',
    },
    {
      'title': 'Push-up',
      'subtitle': 'Morning-45min',
      'calories': '+350kcal',
      'time': '', 
    },
  ];

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
              // --- HEADER LIFETRACK ---
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
              const SizedBox(height: 30),

              // --- LIST AKTIVITAS ---
              Column(
                children: _activities.map((activity) {
                  return _buildActivityCard(activity);
                }).toList(),
              ),
              const SizedBox(height: 15),

              // --- BUTTON LOG YOUR ACTIVITY ---
              GestureDetector(
                onTap: () {
                  // Jika ada aktivitas yang diseleksi, kirim balik ke Page 1
                  if (_selectedActivity != null) {
                    Navigator.pop(context, _selectedActivity);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pilih aktivitas terlebih dahulu!')),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    // Warna tombol berubah jadi hijau tua jika sudah ada item yang dipilih
                    color: _selectedActivity != null 
                        ? const Color(0xFF0F5A47) 
                        : const Color(0xFFE2E8E5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: _selectedActivity != null ? Colors.white : Colors.black.withOpacity(0.5),
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Log your activity',
                        style: TextStyle(
                          fontSize: 16,
                          color: _selectedActivity != null ? Colors.white : Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Builder untuk Card Aktivitas
  Widget _buildActivityCard(Map<String, dynamic> activity) {
    // Cek apakah item ini yang sedang dipilih
    final isSelected = _selectedActivity?['title'] == activity['title'];

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedActivity = activity; // Simpan ke state saat card diklik
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFE2E8E5),
          borderRadius: BorderRadius.circular(4),
          // Beri border hijau penanda jika card ini diklik/dipilih
          border: Border.all(
            color: isSelected ? const Color(0xFF0F5A47) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Baris Atas: Judul & Kalori
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['title'],
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  activity['calories'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),

            // Baris Bawah: Waktu, Jam & Tombol Tambah
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity['subtitle'],
                      style: const TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                    if (activity['time'].toString().isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        activity['time'],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ],
                ),
                // Tombol tambah lingkaran kecil di kanan bawah
                IconButton(
                  onPressed: () {
                    // Jika tombol tambah kecil ini ditekan, langsung kirim data instan ke Page 1
                    Navigator.pop(context, activity);
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: isSelected ? const Color(0xFF0F5A47) : Colors.black.withOpacity(0.5),
                    size: 26,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}