import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';

/// Chip sélectionnable. [pill] = forme arrondie (chambres, équipements),
/// sinon rectangle arrondi (type de bien).
class OptionChip extends StatelessWidget {
  const OptionChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.pill = true,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool pill;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: pill ? 13 : 10, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? C.navy : Colors.white,
          borderRadius: BorderRadius.circular(pill ? 20 : 11),
          border: Border.all(color: selected ? C.navy : C.line),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : C.text,
          ),
        ),
      ),
    );
  }
}