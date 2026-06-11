import 'dart:math' as math;
import 'package:flutter/material.dart';

class DonutPainter extends CustomPainter {
  final double proteinRatio;
  final double carbsRatio;
  final double fatsRatio;

  DonutPainter({
    required this.proteinRatio,
    required this.carbsRatio,
    required this.fatsRatio,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2, cy = size.height / 2;
    final radius = (size.width / 2) - 6;
    const strokeW = 10.0;

    canvas.drawCircle(
      Offset(cx, cy), radius,
      Paint()
        ..color = const Color(0xFFF0F5F2)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeW
        ..strokeCap = StrokeCap.round,
    );

    final segments = [
      (proteinRatio.clamp(0.0, 1.0), const Color(0xFF0D6E5C)),
      (carbsRatio.clamp(0.0, 1.0), const Color(0xFF3B4A6B)),
      (fatsRatio.clamp(0.0, 1.0), const Color(0xFFE07070)),
    ];

    final totalVal = segments.fold(0.0, (s, e) => s + e.$1);
    double start = -math.pi / 2;
    const gap = 0.15;
    final total = 2 * math.pi - (gap * segments.length);

    for (final (val, col) in segments) {
      final proportion = totalVal > 0 ? val / totalVal : 1 / 3;
      final sweep = total * proportion;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(cx, cy), radius: radius),
        start, sweep, false,
        Paint()
          ..color = col
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeW
          ..strokeCap = StrokeCap.round,
      );
      start += sweep + gap;
    }
  }

  @override
  bool shouldRepaint(DonutPainter old) =>
      old.proteinRatio != proteinRatio ||
      old.carbsRatio != carbsRatio ||
      old.fatsRatio != fatsRatio;
}

class MacrosCard extends StatelessWidget {
  final double proteinG;
  final double carbsG;
  final double fatsG;
  final double proteinGoal;
  final double carbsGoal;
  final double fatsGoal;

  const MacrosCard({
    super.key,
    required this.proteinG,
    required this.carbsG,
    required this.fatsG,
    required this.proteinGoal,
    required this.carbsGoal,
    required this.fatsGoal,
  });

  @override
  Widget build(BuildContext context) {
    final pRatio = proteinGoal > 0 ? (proteinG / proteinGoal).clamp(0.0, 1.0) : 0.0;
    final cRatio = carbsGoal > 0 ? (carbsG / carbsGoal).clamp(0.0, 1.0) : 0.0;
    final fRatio = fatsGoal > 0 ? (fatsG / fatsGoal).clamp(0.0, 1.0) : 0.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            height: 90,
            child: CustomPaint(
              painter: DonutPainter(proteinRatio: pRatio, carbsRatio: cRatio, fatsRatio: fRatio),
              child: const Center(
                child: Icon(Icons.restaurant_menu, color: Color(0xFF0D6E5C), size: 22),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Macros Today',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF4A7C6A))),
                const SizedBox(height: 10),
                _macroRow('Protein', proteinG, proteinGoal, const Color(0xFF0D6E5C)),
                const SizedBox(height: 8),
                _macroRow('Carbs', carbsG, carbsGoal, const Color(0xFF3B4A6B)),
                const SizedBox(height: 8),
                _macroRow('Fats', fatsG, fatsGoal, const Color(0xFFE07070)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _macroRow(String label, double current, double goal, Color color) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(label,
              style: const TextStyle(fontSize: 12, color: Color(0xFF5A7A6A), fontWeight: FontWeight.w500)),
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(text: '${current.toStringAsFixed(0)}g',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
            TextSpan(text: ' /${goal.toStringAsFixed(0)}g',
                style: const TextStyle(fontSize: 11, color: Color(0xFFAACBB8))),
          ]),
        ),
      ],
    );
  }
}