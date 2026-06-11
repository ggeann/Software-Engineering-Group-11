import 'package:flutter/material.dart';

class AddFoodButton extends StatelessWidget {
  final VoidCallback? onTap;

  const AddFoodButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline, size: 16, color: Color(0xFF4A9E7A)),
            SizedBox(width: 6),
            Text('+ Add Food',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF4A9E7A))),
          ],
        ),
      ),
    );
  }
}