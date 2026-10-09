import '../entities/property_search_filter.dart';
import '../entities/property_summary.dart';

abstract class SearchRepository {
  Future<List<PropertySummary>> search(PropertySearchFilter filter);
}