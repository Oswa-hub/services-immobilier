import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/property_search_filter.dart';
import '../domain/entities/search_enums.dart';

class SearchFilterNotifier extends Notifier<PropertySearchFilter> {
  @override
  PropertySearchFilter build() => const PropertySearchFilter();

  void setTransaction(TransactionType type) {
    state = state.copyWith(transactionType: type);
  }

  /// Tap w9a3 thenya = désélection.
  void setPropertyType(PropertyType type) {
    state = state.propertyType == type
        ? state.copyWith(propertyType: null)
        : state.copyWith(propertyType: type);
  }

  void setLocation({String? governorate, String? city, String? area}) {
    state = state.copyWith(
      governorate: governorate,
      city: city,
      area: area,
    );
  }

  void setPriceRange(double? min, double? max) {
    state = state.copyWith(
      minPrice: min,
      maxPrice: max,
    );
  }

  /// 0 = studio, 1, 2, 3, 4 = "4+". Tap w9a3 thenya = désélection.
  void setBedrooms(int value) {
    state = state.bedrooms == value
        ? state.copyWith(bedrooms: null)
        : state.copyWith(bedrooms: value);
  }

  /// 1, 2, 3 = "3+". Tap w9a3 thenya = désélection.
  void setBathrooms(int value) {
    state = state.bathrooms == value
        ? state.copyWith(bathrooms: null)
        : state.copyWith(bathrooms: value);
  }

  void setSurfaceRange(double? min, double? max) {
    state = state.copyWith(minSurface: min, maxSurface: max);
  }

  void toggleAmenity(Amenity amenity) {
    final next = {...state.amenities};
    if (!next.remove(amenity)) next.add(amenity);
    state = state.copyWith(amenities: next);
  }

  void setSort(SortOption sort) {
    state = state.copyWith(sort: sort);
  }

  void reset() {
    state = const PropertySearchFilter();
  }
}

final searchFilterProvider =
    NotifierProvider<SearchFilterNotifier, PropertySearchFilter>(
  SearchFilterNotifier.new,
);