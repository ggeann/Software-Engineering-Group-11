import 'package:flutter/material.dart';

class HabitPlannerSection extends StatefulWidget {
  const HabitPlannerSection({Key? key}) : super(key: key);

  @override
  _HabitPlannerSectionState createState() => _HabitPlannerSectionState();
}

class _HabitPlannerSectionState extends State<HabitPlannerSection> {
  // Data dummy list kebiasaan berdasarkan desain Figma
  final List<Map<String, dynamic>> habits = [
    {
      "title": "Sleep 8 hours",
      "isDone": true,
      "icon": Icons.dark_mode_outlined,
    },
    {"title": "No Added Sugar", "isDone": false, "icon": Icons.block},
    {
      "title": "Meditation (10m)",
      "isDone": true,
      "icon": Icons.self_improvement,
    },
    {
      "title": "Drink 2L Water",
      "isDone": false,
      "icon": Icons.water_drop_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Bagian Header (Judul & Badge) ---
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Habit Planner",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(
                  0xFFD1EAE0,
                ), // Warna background hijau muda badge
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "4 of 6 done",
                style: TextStyle(
                  color: Color(0xFF4A8B71), // Warna teks badge
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // --- Bagian List Card ---
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            // Opsional: Tambahkan shadow tipis jika background utama bukan putih
            // boxShadow: [
            //   BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
            // ],
          ),
          child: ListView.separated(
            shrinkWrap:
                true, // Penting agar tidak error di dalam Column/ScrollView
            physics:
                const NeverScrollableScrollPhysics(), // Scroll mengikuti halaman utama
            itemCount: habits.length,
            separatorBuilder: (context, index) => const Divider(
              color: Color(0xFFF0F0F0),
              height: 1,
              thickness: 1,
              indent: 16,
              endIndent: 16,
            ),
            itemBuilder: (context, index) {
              final habit = habits[index];
              return ListTile(
                leading: Checkbox(
                  value: habit["isDone"],
                  activeColor: const Color(0xFF006B54), // Hijau gelap LifeTrack
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  side: const BorderSide(color: Colors.grey, width: 1.5),
                  onChanged: (bool? newValue) {
                    setState(() {
                      habit["isDone"] = newValue!;
                    });
                  },
                ),
                title: Text(
                  habit["title"],
                  style: TextStyle(
                    // Warna teks agak pudar jika sudah diceklis
                    color: habit["isDone"]
                        ? Colors.grey.shade600
                        : Colors.black87,
                    fontSize: 15,
                  ),
                ),
                trailing: Icon(
                  habit["icon"],
                  color: Colors.grey.shade400,
                  size: 20,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
