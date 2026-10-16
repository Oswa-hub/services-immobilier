import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/price_formatter.dart';
import '../../../core/widgets/property_image.dart';
import '../providers/property_providers.dart';

/// TEMPORARY `/property/:id` page. It already uses the real foundation Module 05 builds on
/// (`propertyDetailsProvider`, `similarPropertiesProvider`, Cloudinary `PropertyImage`),
/// so the by-id loading, the failure states and the images can be verified today.
/// Module 05 replaces this widget (same route, same `id` parameter).
class PropertyDetailsStubPage extends ConsumerWidget {
  const PropertyDetailsStubPage({super.key, required this.propertyId});

  final String propertyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final load = ref.watch(propertyDetailsProvider(propertyId));

    return Scaffold(
      appBar: AppBar(title: const Text('Property')),
      body: load.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => _Message(
          message: 'Something went wrong while loading this property.',
          onRetry: () => ref.invalidate(propertyDetailsProvider(propertyId)),
        ),
        data: (result) {
          final p = result.property;
          if (p == null) {
            final retryable = result.failure!.type.name == 'network' || result.failure!.type.name == 'unknown';
            return _Message(
              message: result.failure!.message,
              onRetry: retryable ? () => ref.invalidate(propertyDetailsProvider(propertyId)) : null,
            );
          }
          final similar = ref.watch(similarPropertiesProvider(propertyId));
          return ListView(
            children: [
              AspectRatio(
                aspectRatio: 16 / 10,
                child: PropertyImage(url: p.mainImage, size: PropertyImageSize.gallery),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(PriceFormatter.format(p.price, p.currency, p.transactionType),
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.primary)),
                  const SizedBox(height: 6),
                  Text(p.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(p.locationLabel, style: const TextStyle(color: AppColors.muted)),
                  if (p.description.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    Text(p.description),
                  ],
                  const SizedBox(height: 20),
                  Text(
                    similar.maybeWhen(
                      data: (list) => '${list.length} similar properties found',
                      orElse: () => 'Looking for similar properties...',
                    ),
                    style: const TextStyle(color: AppColors.muted),
                  ),
                  const SizedBox(height: 20),
                  const Text('Full details page arrives with Module 05.',
                      style: TextStyle(color: AppColors.muted, fontStyle: FontStyle.italic)),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.home_work_outlined, size: 56, color: AppColors.primary),
            const SizedBox(height: 14),
            Text(message, textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              FilledButton(onPressed: onRetry, child: const Text('Retry')),
            ],
          ]),
        ),
      );
}
