import 'package:flutter/material.dart';

class EditMealLogSheet extends StatefulWidget {
  final dynamic log;

  const EditMealLogSheet({super.key, required this.log});

  @override
  State<EditMealLogSheet> createState() => _EditMealLogSheetState();
}

class _EditMealLogSheetState extends State<EditMealLogSheet> {
  late double _servingQty;

  @override
  void initState() {
    super.initState();
    _servingQty = widget.log.servingQty ?? 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 40, height: 4,
              decoration: BoxDecoration(color: const Color(0xFFDDE8DD), borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 16),
          Text('Edit ${widget.log.foodName}',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: _servingQty > 0.5 ? () => setState(() => _servingQty -= 0.5) : null,
              ),
              Text('${_servingQty.toStringAsFixed(_servingQty == _servingQty.roundToDouble() ? 0 : 1)} serving',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () => setState(() => _servingQty += 0.5),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D6E5C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }
}