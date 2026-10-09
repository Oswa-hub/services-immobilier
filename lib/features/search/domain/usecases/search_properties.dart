import '../entities/property_search_filter.dart';
import '../entities/property_summary.dart';
import '../repositories/search_repository.dart';

class SearchProperties {
  const SearchProperties(this._repository);
  final SearchRepository _repository;

  Future<List<PropertySummary>> call(PropertySearchFilter filter) =>
      _repository.search(filter);
}