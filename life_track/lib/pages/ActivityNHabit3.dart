import 'package:flutter/material.dart';

class ActivityNHabitPage3 extends StatefulWidget {
  const ActivityNHabitPage3({super.key});

  @override
  State<ActivityNHabitPage3> createState() => _ActivityNHabitPage3State();
}

class _ActivityNHabitPage3State extends State<ActivityNHabitPage3> {
  // 1. Daftar habit yang tersedia untuk dipilih
  final List<Map<String, dynamic>> _availableHabits = [
    {'title': 'Sleep', 'subtitle': '8 hours', 'icon': Icons.dark_mode_outlined},
    {
      'title': 'Drink',
      'subtitle': '2L Water',
      'icon': Icons.water_drop_outlined,
    },
    {'title': 'Read', 'subtitle': '30 pages', 'icon': Icons.menu_book},
    {
      'title': 'Meditation',
      'subtitle': '15 mins',
      'icon': Icons.self_improvement,
    },
  ];

  // 2. Menyimpan index habit mana saja yang diklik/dipilih user
  final Set<int> _selectedIndices = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF4F9F6,
      ), // Background hijau pucat estetik
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 30.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- HEADER LIFETRACK ---
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
                            color: Color(0xFF006B54),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // --- TITLE ---
                    const Text(
                      'Habit Planner',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Choose habits you want to build.',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 24),

                    // --- HABIT CARDS GRID/LIST ---
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _availableHabits.length,
                      itemBuilder: (context, index) {
                        final habit = _availableHabits[index];
                        final isSelected = _selectedIndices.contains(index);

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              // Toggle pilihan (tambah jika belum ada, hapus jika sudah ada)
                              if (isSelected) {
                                _selectedIndices.remove(index);
                              } else {
                                _selectedIndices.add(index);
                              }
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFE8F3EF)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF006B54)
                                    : Colors.transparent,
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Ikon Habit
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFF006B54)
                                        : const Color(0xFFF4F9F6),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    habit['icon'],
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF006B54),
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Teks Habit
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        habit['title'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        habit['subtitle'],
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Indikator Checkmark jika dipilih
                                if (isSelected)
                                  const Icon(
                                    Icons.check_circle,
                                    color: Color(0xFF006B54),
                                    size: 28,
                                  )
                                else
                                  Icon(
                                    Icons.circle_outlined,
                                    color: Colors.black.withOpacity(0.1),
                                    size: 28,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // --- BOTTOM BUTTON: SET YOUR HABIT ---
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: ElevatedButton(
                // Tombol hanya bisa diklik jika ada minimal 1 habit yang dipilih
                onPressed: _selectedIndices.isEmpty
                    ? null
                    : () {
                        // Mengumpulkan data habit yang dipilih
                        List<Map<String, dynamic>> selectedHabitsData =
                            _selectedIndices.map((index) {
                              return _availableHabits[index];
                            }).toList();

                        // Kembali ke Page 1 dengan membawa data
                        Navigator.pop(context, selectedHabitsData);
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
                child: Text(
                  'Set ${_selectedIndices.isEmpty ? '' : '${_selectedIndices.length} '}Habit',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _selectedIndices.isEmpty
                        ? Colors.grey.shade500
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
