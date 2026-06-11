import 'package:flutter/material.dart';

class ServingSelector extends StatelessWidget {
  final double qty;
  final String label;
  final ValueChanged<double> onChanged;

  const ServingSelector({
    super.key,
    required this.qty,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Serving', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: qty > 0.5 ? () => onChanged(qty - 0.5) : null,
                color: const Color(0xFF0D6E5C),
              ),
              Text(
                '${qty.toStringAsFixed(qty == qty.roundToDouble() ? 0 : 1)}x',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () => onChanged(qty + 0.5),
                color: const Color(0xFF0D6E5C),
              ),
            ],
          ),
        ],
      ),
    );
  }
}