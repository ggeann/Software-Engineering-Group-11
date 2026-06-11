import 'package:flutter/material.dart';

class FoodSearchBar extends StatelessWidget {
  final VoidCallback? onTap;

  const FoodSearchBar({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6)],
        ),
        child: const Row(
          children: [
            SizedBox(width: 14),
            Icon(Icons.search, color: Color(0xFFAACBB8), size: 20),
            SizedBox(width: 8),
            Text('Search food to log...',
                style: TextStyle(color: Color(0xFFAACBB8), fontSize: 14)),
          ],
        ),
      ),
    );
  }
}