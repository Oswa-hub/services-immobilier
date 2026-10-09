import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/property_search_filter.dart';
import '../../domain/entities/property_summary.dart';
import '../models/property_summary_model.dart';

class FirestoreSearchDatasource {
  FirestoreSearchDatasource(this._db);
  final FirebaseFirestore _db;

  Future<List<PropertySummary>> fetch(PropertySearchFilter f) async {
    Query<Map<String, dynamic>> q =
        _db.collection('properties').where('status', isEqualTo: 'published');

    if (f.transactionType != null) {
      q = q.where('transactionType', isEqualTo: f.transactionType!.name);
    }
    if (f.propertyType != null) {
      q = q.where('propertyType', isEqualTo: f.propertyType!.name);
    }
    if (f.governorate != null) {
      q = q.where('governorate', isEqualTo: f.governorate);
    }
    if (f.city != null) {
      q = q.where('city', isEqualTo: f.city);
    }
    if (f.area != null) {
      q = q.where('area', isEqualTo: f.area);
    }

    final snap = await q.limit(200).get();
    return snap.docs.map(PropertySummaryModel.fromDoc).toList();
  }
}