import 'package:flutter/material.dart';
// Pastikan path import ini sesuai dengan struktur project kamu
import 'ActivityNHabit2.dart';
import 'ActivityNHabit3.dart'; // IMPORT PAGE 3 DI SINI

class ActivityNHabitPage1 extends StatefulWidget {
  const ActivityNHabitPage1({super.key});

  @override
  State<ActivityNHabitPage1> createState() => _ActivityNHabitPage1State();
}

class _ActivityNHabitPage1State extends State<ActivityNHabitPage1> {
  // 1. Menampung daftar aktivitas yang di-log secara dinamis.
  final List<Map<String, dynamic>> _loggedActivities = [
    {
      'title': 'Running',
      'subtitle': 'Morning • 45 min',
      'calories': '+300 kcal',
      'time': '07:20 AM',
      'icon': Icons.directions_run,
    },
    {
      'title': 'Swimming',
      'subtitle': 'Evening • 45 min',
      'calories': '+250 kcal',
      'time': '--:--',
      'icon': Icons.pool,
    },
  ];

  // 2. Menampung daftar Habit agar checkbox-nya bisa berfungsi (Stateful)
  final List<Map<String, dynamic>> _habits = [
    {
      'title': 'Sleep 8 hours',
      'isDone': true,
      'icon': Icons.dark_mode_outlined,
    },
    {'title': 'No Added Sugar', 'isDone': false, 'icon': Icons.block},
    {
      'title': 'Meditation (10m)',
      'isDone': true,
      'icon': Icons.self_improvement,
    },
    {
      'title': 'Drink 2L Water',
      'isDone': false,
      'icon': Icons.water_drop_outlined,
    },
  ];

  // Fungsi navigasi ke Page 2
  Future<void> _navigateAndLogActivity(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ActivityNHabitPage2()),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        if (!result.containsKey('icon')) {
          result['icon'] = Icons.fitness_center;
        }
        _loggedActivities.add(result);
      });
    }
  }

  // Menghitung jumlah habit yang sudah selesai untuk badge otomatis
  int get _completedHabitsCount =>
      _habits.where((habit) => habit['isDone'] == true).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F9F6),

      // Bagian body di-wrap dengan SafeArea agar posisinya aman di bawah status bar HP
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 1. HEADER UTAMA (LINGKARAN MERAH DIPINDAH KE PALING ATAS) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Memanggil aset gambar LifeTrack.png
                      Image.asset(
                        'images/LifeTrack.png',
                        height: 32, // Sesuaikan ukuran logonya
                        // Menghapus errorBuilder berisi Icon Love agar tidak muncul lagi jika gambar gagal dimuat
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'LifeTrack',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF006B54), // Hijau gelap LifeTrack
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_none,
                          color: Colors.black87,
                        ),
                        onPressed: () {},
                      ),
                      const CircleAvatar(
                        backgroundColor: Color(0xFF006B54),
                        radius: 16,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // --- 2. DAILY ACTIVITY SUMMARY CARD ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Daily Activity',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              '1,950',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                'kcal',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black.withValues(alpha: 0.5),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: 0.7,
                        strokeWidth: 6,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF006B54),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // --- HEADER ACTIVITY LOG ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Activity Log',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        color: Color(0xFF006B54),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // --- 3. DYNAMIC ACTIVITY LIST ---
              Column(
                children: _loggedActivities.map((activity) {
                  return _buildActivityCard(activity);
                }).toList(),
              ),

              // --- 4. BUTTON: LOG YOUR ACTIVITY ---
              GestureDetector(
                onTap: () => _navigateAndLogActivity(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  margin: const EdgeInsets.only(bottom: 32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF006B54).withValues(alpha: 0.3),
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add, color: Color(0xFF006B54), size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Log your activity',
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color(0xFF006B54).withValues(alpha: 0.9),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // --- 5. HABIT PLANNER SECTION ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Habit Planner',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD1EAE0),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$_completedHabitsCount of ${_habits.length} done', // Badge dinamis
                      style: const TextStyle(
                        color: Color(0xFF006B54),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Generate list habit yang tombolnya bisa diklik
                    ...List.generate(_habits.length, (index) {
                      return Column(
                        children: [
                          _buildHabitRow(index),
                          // Tambahkan garis pembatas kecuali di item terakhir
                          if (index < _habits.length - 1)
                            const Divider(
                              height: 1,
                              color: Color(0xFFF0F0F0),
                              indent: 16,
                              endIndent: 16,
                            ),
                        ],
                      );
                    }),
                    const Divider(
                      height: 1,
                      color: Color(0xFFF0F0F0),
                      indent: 16,
                      endIndent: 16,
                    ),

                    // --- BUTTON SET YOUR HABIT (YANG SUDAH DIPERBARUI) ---
                    InkWell(
                      onTap: () async {
                        // 1. Pindah ke Page 3 dan tunggu balasan datanya
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ActivityNHabitPage3(),
                          ),
                        );

                        // 2. Jika user memilih habit dan datanya tidak kosong
                        if (result != null &&
                            result is List<Map<String, dynamic>>) {
                          setState(() {
                            // 3. Masukkan habit baru tersebut ke dalam list _habits di Page 1
                            for (var newHabit in result) {
                              _habits.add({
                                // Menggabungkan Title & Subtitle agar rapi di Page 1 (Contoh: "Sleep 8 hours")
                                'title':
                                    '${newHabit['title']} ${newHabit['subtitle']}',
                                'isDone':
                                    false, // Default checklist belum dicentang
                                'icon': newHabit['icon'],
                              });
                            }
                          });
                        }
                      },
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(16),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 18,
                              color: Colors.black.withValues(alpha: 0.4),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Set your habit',
                              style: TextStyle(
                                color: Colors.black.withValues(alpha: 0.5),
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET PENDUKUNG ---

  // Fungsi untuk baris Habit yang interaktif
  Widget _buildHabitRow(int index) {
    final habit = _habits[index];
    final bool isDone = habit['isDone'];

    return ListTile(
      onTap: () {
        // Mengubah status checklist saat diklik
        setState(() {
          _habits[index]['isDone'] = !isDone;
        });
      },
      leading: Icon(
        isDone ? Icons.check_box : Icons.check_box_outline_blank,
        color: isDone ? const Color(0xFF006B54) : Colors.grey.shade400,
      ),
      title: Text(
        habit['title'],
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: isDone ? Colors.grey.shade500 : Colors.black87,
          decoration: isDone
              ? TextDecoration.lineThrough
              : null, // Efek coret jika selesai
        ),
      ),
      trailing: Icon(habit['icon'], color: Colors.grey.shade400, size: 22),
    );
  }

  // Fungsi untuk list Activity
  Widget _buildActivityCard(Map<String, dynamic> activity) {
    final String timeDisplay =
        (activity['time'] != null && activity['time'].toString().isNotEmpty)
        ? activity['time']
        : '--:--';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F7F4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              activity['icon'] ?? Icons.fitness_center,
              color: const Color(0xFF006B54),
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['title'] ?? 'Unknown Activity',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  activity['subtitle'] ?? '',
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                activity['calories'] ?? '0 kcal',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF006B54),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                timeDisplay,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
