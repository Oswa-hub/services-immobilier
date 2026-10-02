import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../../widgets/common_widgets.dart';
import 'map_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String mode = 'Acheter';
  String property = 'Appartement';
  double area = 120;

  Widget sectionTitle(String a, String b) => Padding(
    padding: const EdgeInsets.only(top: 18, bottom: 9),
    child: Row(children: [
      Expanded(child: Text(a, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800))),
      Text(b, style: const TextStyle(fontSize: 9, color: C.muted)),
    ]),
  );

  Widget choice(String label, bool selected) => GestureDetector(
    onTap: () => setState(() => property = label),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? C.navy : Colors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: selected ? C.navy : C.line),
      ),
      child: Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: selected ? Colors.white : C.text)),
    ),
  );

  Widget smallChip(String label, bool selected) => Container(
    margin: const EdgeInsets.only(right: 6),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(color: selected ? C.navy : Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: selected ? C.navy : C.line)),
    child: Text(label, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: selected ? Colors.white : C.text)),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(16, 8, 16, 24), children: [
      const AppBarSimple('Rechercher', back: false),
      const SearchBox(),
      const SizedBox(height: 10),
      SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
        for (final x in ['Acheter','Louer','Neuf'])
          GestureDetector(onTap: () => setState(() => mode = x), child: FilterPill(x, selected: mode == x)),
      ])),
      sectionTitle('Type de bien', 'Obligatoire'),
      GridView.count(
        crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 7, crossAxisSpacing: 7, childAspectRatio: 4.3,
        children: [for (final x in ['Appartement','Villa / Maison','Duplex / Triplex','Terrain','Bureaux, commerces']) choice(x, property == x)],
      ),
      sectionTitle('Fourchette de Budget', 'Budget en Dinars (TND)'),
      Row(children: const [
        Expanded(child: TextField(decoration: InputDecoration(labelText:'Min', hintText:'250 000'))),
        SizedBox(width: 8),
        Expanded(child: TextField(decoration: InputDecoration(labelText:'Max', hintText:'1 500 000'))),
      ]),
      sectionTitle('Chambres (S+)', '3 sélectionné'),
      SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [for (final x in ['Studio','1','2','3','4+']) smallChip(x, x == '3')])),
      sectionTitle('Salles de bain', '2 sélectionné'),
      SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [for (final x in ['1','2','3+']) smallChip(x, x == '2')])),
      sectionTitle('Superficie minimum', '${area.round()} m²'),
      Slider(value: area, min: 50, max: 500, onChanged: (v) => setState(() => area = v), activeColor: C.navy),
      sectionTitle('Prestations & Commodités', 'Voir tout'),
      Wrap(spacing: 6, runSpacing: 6, children: [for (final x in ['🌊 Vue mer','⌂ Parking','◉ Piscine','↕ Ascenseur','🌿 Jardin privé','♨ Chauffage central','✓ Résidence gardée']) smallChip(x, false)]),
      sectionTitle('Recherches récentes', 'Effacer'),
      const NearbyCard(image:'apartment.jpg', price:'34 biens', title:'Les Berges du Lac II', location:'Appartement • S+2, S+3', tag:'Récent'),
      const SizedBox(height: 8),
      const NearbyCard(image:'villa.jpg', price:'18 biens', title:'Sousse - Port El Kantaoui', location:'Villa bord de mer', tag:'Récent'),
      const SizedBox(height: 15),
      Container(padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: const Color(0xFFEAF4FA), borderRadius: BorderRadius.circular(12)), child: const Text('✓ Zones côtières à forte valeur\nIndices immobiliers vérifiés avec actes individuels (Titre Bleu).', style: TextStyle(fontSize: 9, color: C.secondary, fontWeight: FontWeight.w600))),
      const SizedBox(height: 16),
      Row(children: [
        Expanded(child: OutlinedButton(onPressed: () => setState(() { mode='Acheter'; property='Appartement'; area=120; }), child: const Text('Réinitialiser'))),
        const SizedBox(width: 8),
        Expanded(child: FilledButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MapPage())), style: FilledButton.styleFrom(backgroundColor: C.navy), child: const Text('Afficher les résultats'))),
      ]),
    ]));
  }
}
