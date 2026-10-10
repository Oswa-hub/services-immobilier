import 'package:flutter/material.dart';

import '../../features/search/presentation/pages/search_filters_page.dart';

/// Gardé pour ne pas casser main_shell.dart / common_widgets.dart.
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) => const SearchFiltersPage();
}