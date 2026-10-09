import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/datasources/firestore_search_datasource.dart';
import '../data/repositories/search_repository_impl.dart';
import '../domain/entities/property_summary.dart';
import '../domain/repositories/search_repository.dart';
import '../domain/usecases/search_properties.dart';
import 'search_filter_provider.dart';

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  return SearchRepositoryImpl(
    FirestoreSearchDatasource(FirebaseFirestore.instance),
  );
});

final searchPropertiesProvider = Provider<SearchProperties>((ref) {
  return SearchProperties(ref.watch(searchRepositoryProvider));
});

/// Se relance automatiquement kol ma el filtre yetbaddel.
final searchResultsProvider =
    FutureProvider.autoDispose<List<PropertySummary>>((ref) {
  final filter = ref.watch(searchFilterProvider);
  return ref.watch(searchPropertiesProvider)(filter);
});