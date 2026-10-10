import '../../domain/entities/search_enums.dart';

extension TransactionTypeLabel on TransactionType {
  String get label => switch (this) {
        TransactionType.buy => 'Acheter',
        TransactionType.rent => 'Louer',
        TransactionType.newBuild => 'Neuf',
      };
}

extension PropertyTypeLabel on PropertyType {
  String get label => switch (this) {
        PropertyType.apartment => 'Appartement',
        PropertyType.villa => 'Villa',
        PropertyType.house => 'Maison',
        PropertyType.duplex => 'Duplex',
        PropertyType.triplex => 'Triplex',
        PropertyType.land => 'Terrain',
        PropertyType.office => 'Bureau',
        PropertyType.commercial => 'Commerce',
        PropertyType.industrial => 'Industriel',
      };
}

extension AmenityLabel on Amenity {
  String get label => switch (this) {
        Amenity.parking => 'Parking',
        Amenity.pool => 'Piscine',
        Amenity.elevator => 'Ascenseur',
        Amenity.garden => 'Jardin',
        Amenity.seaView => 'Vue mer',
        Amenity.centralHeating => 'Chauffage central',
        Amenity.airConditioning => 'Climatisation',
        Amenity.security => 'Sécurité',
        Amenity.terrace => 'Terrasse',
        Amenity.balcony => 'Balcon',
      };
}

extension SortOptionLabel on SortOption {
  String get label => switch (this) {
        SortOption.recommended => 'Recommandés',
        SortOption.newest => 'Plus récents',
        SortOption.lowestPrice => 'Prix croissant',
        SortOption.highestPrice => 'Prix décroissant',
        SortOption.largestSurface => 'Plus grande surface',
        SortOption.closest => 'Plus proches',
      };
}

const tunisianGovernorates = <String>[
  'Ariana', 'Béja', 'Ben Arous', 'Bizerte', 'Gabès', 'Gafsa', 'Jendouba',
  'Kairouan', 'Kasserine', 'Kébili', 'Kef', 'Mahdia', 'Manouba', 'Médenine',
  'Monastir', 'Nabeul', 'Sfax', 'Sidi Bouzid', 'Siliana', 'Sousse',
  'Tataouine', 'Tozeur', 'Tunis', 'Zaghouan',
];