import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/providers/auth_provider.dart';

/// Temporary landing pages that prove role resolution works.
/// Replace with the real modules (Home/Search, Admin) later.
class HomePlaceholderPage extends ConsumerWidget {
  const HomePlaceholderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => _RoleLanding(title: 'Home', ref: ref);
}

class AdminPlaceholderPage extends ConsumerWidget {
  const AdminPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      _RoleLanding(title: 'Admin dashboard', ref: ref);
}

class _RoleLanding extends StatelessWidget {
  const _RoleLanding({required this.title, required this.ref});
  final String title;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Welcome, ${user?.name ?? user?.email ?? ''}',
                  style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text('role: ${user?.role.name}  •  status: ${user?.status.name}'),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => ref.read(authControllerProvider.notifier).logout(),
                child: const Text('Log out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
