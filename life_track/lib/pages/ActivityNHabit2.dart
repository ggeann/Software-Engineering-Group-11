import 'package:flutter/material.dart';

class ActivityNHabitPage2 extends StatefulWidget {
  const ActivityNHabitPage2({super.key});

  @override
  State<ActivityNHabitPage2> createState() => _ActivityNHabitPage2State();
}

class _ActivityNHabitPage2State extends State<ActivityNHabitPage2> {
  // State untuk menyimpan aktivitas mana yang sedang dipilih/diklik oleh user
  Map<String, dynamic>? _selectedActivity;

  // Menambahkan icon agar senada dengan UI Page 1 dan Page 3
  final List<Map<String, dynamic>> _activities = [
    {
      'title': 'Jogging',
      'subtitle': 'Evening • 45 min',
      'calories': '+300 kcal',
      'time': '07:20 AM',
      'icon': Icons.directions_run,
    },
    {
      'title': 'Push-up',
      'subtitle': 'Morning • 45 min',
      'calories': '+350 kcal',
      'time': '--:--',
      'icon': Icons.fitness_center,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF4F9F6,
      ), // Background estetik hijau pucat
      body: SafeArea(
        child: Column(
          children: [
            // --- BAGIAN KONTEN (Bisa di-scroll) ---
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 30.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- 1. HEADER LIFETRACK ---
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            'images/LifeTrack.png',
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Icon(
                                    Icons.broken_image,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'LifeTrack',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF006B54), // Hijau gelap
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // --- 2. TITLE SECTION ---
                    const Text(
                      'Log Activity',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Select an activity to record your progress.',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 24),

                    // --- 3. DYNAMIC ACTIVITY LIST ---
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _activities.length,
                      itemBuilder: (context, index) {
                        return _buildActivityCard(_activities[index]);
                      },
                    ),
                  ],
                ),
              ),
            ),

            // --- 4. BOTTOM BUTTON: LOG YOUR ACTIVITY ---
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: ElevatedButton(
                // Tombol hanya aktif jika _selectedActivity tidak null
                onPressed: _selectedActivity == null
                    ? null
                    : () {
                        Navigator.pop(context, _selectedActivity);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006B54),
                  disabledBackgroundColor: Colors.grey.shade300,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: _selectedActivity == null
                          ? Colors.grey.shade500
                          : Colors.white,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Log your activity',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _selectedActivity == null
                            ? Colors.grey.shade500
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET BUILDER UNTUK CARD AKTIVITAS ---
  Widget _buildActivityCard(Map<String, dynamic> activity) {
    // Cek apakah item ini yang sedang dipilih
    final isSelected = _selectedActivity?['title'] == activity['title'];

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedActivity = activity; // Simpan ke state saat card diklik
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE8F3EF)
              : Colors.white, // Berubah jadi hijau pucat jika dipilih
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF006B54)
                : Colors.transparent, // Border hijau menyala
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Ikon Aktivitas
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF006B54)
                    : const Color(0xFFF0F7F4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                activity['icon'],
                color: isSelected ? Colors.white : const Color(0xFF006B54),
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            // Teks Tengah (Judul & Subjudul)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    activity['subtitle'],
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
            // Info Kanan (Kalori & Waktu & Quick Add)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  activity['calories'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF006B54),
                  ),
                ),
                const SizedBox(height: 4),
                // Jika waktu kosong, tampilkan icon checklist saat dipilih, atau tampilkan waktunya jika ada
                if (isSelected)
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Icon(
                      Icons.check_circle,
                      color: Color(0xFF006B54),
                      size: 20,
                    ),
                  )
                else if (activity['time'].toString().isNotEmpty)
                  Text(
                    activity['time'],
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  )
                else
                  const SizedBox(
                    height: 20,
                  ), // Spacer jika tidak ada waktu dan belum dipilih
              ],
            ),
          ],
        ),
      ),
    );
  }
}
