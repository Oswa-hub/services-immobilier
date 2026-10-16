
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  // Get the currently authenticated user.
  User? get currentUser => _auth.currentUser;

  // Get the current user's document reference.
  DocumentReference<Map<String, dynamic>> _userDocument() {
    final user = currentUser;

    if (user == null) {
      throw StateError('User not authenticated.');
    }

    return _firestore.collection('users').doc(user.uid);
  }

  // Listen for real-time profile changes.
  Stream<Map<String, dynamic>?> watchProfile() {
    final user = currentUser;

    if (user == null) {
      return Stream.value(null);
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .map((snapshot) => snapshot.data());
  }

  // Read profile information from Firestore.
  Future<Map<String, dynamic>> getProfile() async {
    final snapshot = await _userDocument().get();

    if (!snapshot.exists) {
      throw StateError('User profile not found.');
    }

    return snapshot.data()!;
  }

  // Update only fields allowed by Firestore rules.
  Future<void> updateProfile({
    required String name,
    required String phone,
    required String preferredCity,
  }) async {
    await _userDocument().update({
      'name': name.trim(),
      'phone': phone.trim(),
      'preferredCity': preferredCity.trim(),
    });
  }

  // Save the Cloudinary image URL (photoUrl is allowed by the Firestore rules).
  Future<void> updatePhotoUrl(String url) async {
    await _userDocument().update({'photoUrl': url});
    await currentUser?.updatePhotoURL(url);
  }
}
