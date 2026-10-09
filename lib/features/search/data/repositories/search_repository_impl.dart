import '../../domain/entities/property_search_filter.dart';
import '../../domain/entities/property_summary.dart';
import '../../domain/entities/search_enums.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/firestore_search_datasource.dart';

class SearchRepositoryImpl implements SearchRepository {
  SearchRepositoryImpl(this._datasource);
  final FirestoreSearchDatasource _datasource;

  @override
  Future<List<PropertySummary>> search(PropertySearchFilter f) async {
    final all = await _datasource.fetch(f);
    final filtered = all.where((p) => _matches(p, f)).toList();
    _sort(filtered, f.sort);
    return filtered;
  }

  bool _matches(PropertySummary p, PropertySearchFilter f) {
    if (f.minPrice != null && p.price < f.minPrice!) return false;
    if (f.maxPrice != null && p.price > f.maxPrice!) return false;
    if (f.minSurface != null && p.surface < f.minSurface!) return false;
    if (f.maxSurface != null && p.surface > f.maxSurface!) return false;

    final beds = f.bedrooms;
    if (beds != null) {
      if (beds >= 4 ? p.bedrooms < 4 : p.bedrooms != beds) return false;
    }
    final baths = f.bathrooms;
    if (baths != null) {
      if (baths >= 3 ? p.bathrooms < 3 : p.bathrooms != baths) return false;
    }
    if (!p.amenities.containsAll(f.amenities)) return false;
    return true;
  }

  void _sort(List<PropertySummary> list, SortOption sort) {
    int byDate(PropertySummary a, PropertySummary b) =>
        (b.createdAt ?? DateTime(0)).compareTo(a.createdAt ?? DateTime(0));

    switch (sort) {
      case SortOption.lowestPrice:
        list.sort((a, b) => a.price.compareTo(b.price));
      case SortOption.highestPrice:
        list.sort((a, b) => b.price.compareTo(a.price));
      case SortOption.largestSurface:
        list.sort((a, b) => b.surface.compareTo(a.surface));
      case SortOption.newest:
      case SortOption.recommended:
      case SortOption.closest: // needs GPS, handled in Map module
        list.sort(byDate);
    }
  }
}