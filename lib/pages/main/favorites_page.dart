import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../../widgets/common_widgets.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});
  @override Widget build(BuildContext context) => SafeArea(child: ListView(padding: const EdgeInsets.only(bottom: 25), children: [
    const AppBarSimple('Favoris', back: false),
    const Padding(padding: EdgeInsets.symmetric(horizontal:16), child: Text('Vos biens enregistrés', style: TextStyle(color:C.muted, fontSize:11))),
    const SizedBox(height:12),
    const Padding(padding: EdgeInsets.symmetric(horizontal:16), child: Column(children: [
      NearbyCard(image:'villa.jpg', price:'1 250 000', title:'Villa Contemporaine vue Mer', location:'La Marsa, Tunis', tag:'Favori'),
      SizedBox(height:10),
      NearbyCard(image:'apartment.jpg', price:'850 000', title:'Appartement de standing', location:'Les Berges du Lac II', tag:'Favori'),
    ])),
  ]));
}
