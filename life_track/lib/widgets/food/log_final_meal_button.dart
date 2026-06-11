import 'package:flutter/material.dart';

class LogFinalMealButton extends StatelessWidget {
  final VoidCallback? onTap;

  const LogFinalMealButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFCCE8D8), width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline, size: 16, color: Color(0xFF4A9E7A)),
            SizedBox(width: 6),
            Text('Log your final meal',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF4A9E7A))),
          ],
        ),
      ),
    );
  }
}