import 'package:flutter/material.dart';

/// TODO(Module 07): replace every use with the shared favorites toggle
/// (persisted state, auth-aware). Kept in ONE place so the swap is a one-line change.
void onFavoriteTapStub(BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(const SnackBar(content: Text('Favorites are coming soon.')));
}
