import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectedDateHeader extends StatelessWidget {
  final DateTime date;

  const SelectedDateHeader({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    final formatted = DateFormat('EEEE, MMM d').format(date);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(formatted,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF111827))),
    );
  }
}