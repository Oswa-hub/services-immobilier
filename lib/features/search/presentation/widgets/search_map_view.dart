import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../properties/domain/entities/property.dart';

/// Map side of the List/Map switch.
///
/// TODO(Module 06): replace the body with the real map. It receives exactly what the
/// list shows (same applied filter, same results), so switching views never changes
/// the result set.
class SearchMapView extends StatelessWidget {
  const SearchMapView({super.key, required this.items, required this.onShowList});

  final List<Property> items;
  final VoidCallback onShowList;

  @override
  Widget build(BuildContext context) {
    final withCoords = items.where((p) => p.hasCoordinates).length;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.map_outlined, size: 56, color: AppColors.primary),
          const SizedBox(height: 14),
          const Text('The map view is coming soon',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.text)),
          const SizedBox(height: 6),
          Text(
            '$withCoords of ${items.length} results will be shown on the map.',
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 18),
          FilledButton(
            onPressed: onShowList,
            style: FilledButton.styleFrom(minimumSize: const Size(180, 48)),
            child: const Text('Back to list'),
          ),
        ]),
      ),
    );
  }
}
