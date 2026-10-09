import 'search_enums.dart';

class PropertySearchFilter {
  final TransactionType? transactionType;
  final PropertyType? propertyType;
  final String? governorate;
  final String? city;
  final String? area;
  final double? minPrice;
  final double? maxPrice;
  final int? bedrooms; // 0 = studio, 4 = "4+"
  final int? bathrooms; // 3 = "3+"
  final double? minSurface;
  final double? maxSurface;
  final Set<Amenity> amenities;
  final SortOption sort;

  const PropertySearchFilter({
    this.transactionType,
    this.propertyType,
    this.governorate,
    this.city,
    this.area,
    this.minPrice,
    this.maxPrice,
    this.bedrooms,
    this.bathrooms,
    this.minSurface,
    this.maxSurface,
    this.amenities = const {},
    this.sort = SortOption.recommended,
  });

  PropertySearchFilter copyWith({
    TransactionType? transactionType,
    PropertyType? propertyType,
    String? governorate,
    String? city,
    String? area,
    double? minPrice,
    double? maxPrice,
    int? bedrooms,
    int? bathrooms,
    double? minSurface,
    double? maxSurface,
    Set<Amenity>? amenities,
    SortOption? sort,
  }) {
    return PropertySearchFilter(
      transactionType: transactionType ?? this.transactionType,
      propertyType: propertyType ?? this.propertyType,
      governorate: governorate ?? this.governorate,
      city: city ?? this.city,
      area: area ?? this.area,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      minSurface: minSurface ?? this.minSurface,
      maxSurface: maxSurface ?? this.maxSurface,
      amenities: amenities ?? this.amenities,
      sort: sort ?? this.sort,
    );
  }

  /// Nombre de filtres actifs (pour le badge sur le bouton Filtrer).
  int get activeCount =>
      [
        transactionType,
        propertyType,
        governorate,
        city,
        area,
        minPrice,
        maxPrice,
        bedrooms,
        bathrooms,
        minSurface,
        maxSurface,
      ].where((e) => e != null).length +
      amenities.length;
}