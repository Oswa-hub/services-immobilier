import 'search_enums.dart';

class PropertySummary {
  final String id;
  final String title;
  final double price;
  final TransactionType transactionType;
  final PropertyType propertyType;
  final String governorate;
  final String city;
  final String? area;
  final int bedrooms;
  final int bathrooms;
  final double surface;
  final Set<Amenity> amenities;
  final List<String> imageUrls;
  final DateTime? createdAt;
  final double? lat;
  final double? lng;

  const PropertySummary({
    required this.id,
    required this.title,
    required this.price,
    required this.transactionType,
    required this.propertyType,
    required this.governorate,
    required this.city,
    this.area,
    this.bedrooms = 0,
    this.bathrooms = 0,
    this.surface = 0,
    this.amenities = const {},
    this.imageUrls = const [],
    this.createdAt,
    this.lat,
    this.lng,
  });
}