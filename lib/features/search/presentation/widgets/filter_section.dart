import 'package:flutter/material.dart';

import '../../../../core/app_theme.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({
    super.key,
    required this.title,
    required this.child,
    this.hint,
  });

  final String title;
  final String? hint;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 9),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: C.text,
                  ),
                ),
              ),
              if (hint != null)
                Text(hint!, style: const TextStyle(fontSize: 11, color: C.muted)),
            ],
          ),
        ),
        child,
      ],
    );
  }
}