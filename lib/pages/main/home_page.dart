import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../../widgets/common_widgets.dart';
import 'map_page.dart';
import 'publish_page.dart';
import 'search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: AppBarSimple('Accueil')),
          SliverToBoxAdapter(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              const CircleAvatar(radius: 22, backgroundImage: AssetImage('assets/avatar.png')),
              const SizedBox(width: 10),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Bonjour, Karim 👋', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                SizedBox(height: 2),
                Text('Trouvez votre résidence en Tunisie', style: TextStyle(fontSize: 9, color: C.muted)),
              ])),
              Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7), decoration: BoxDecoration(color: const Color(0xFFEAF4FA), borderRadius: BorderRadius.circular(18)),
                child: const Text('📍 Tunis', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700))),
            ]),
          )),
          SliverToBoxAdapter(child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Que recherchez-vous ?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              const SizedBox(height: 9),
              SearchBox(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchPage()))),
              const SizedBox(height: 9),
              SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: const [
                FilterPill('Acheter', selected: true),
                FilterPill('Louer'),
                FilterPill('⌂ Maison & Villa'),
                FilterPill('▦ Appartement'),
              ])),
            ]),
          )),
          const SliverToBoxAdapter(child: SectionHeader('Biens recommandés', 'Top choix')),
          SliverToBoxAdapter(child: SizedBox(
            height: 224,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              children: const [
                PropertyCard(image:'villa.jpg', title:'Villa Contemporaine vue Mer', price:'1 250 000', location:'La Marsa, Tunis', details:'4 ch • 3 sdb • 320 m²'),
                PropertyCard(image:'apartment.jpg', title:'Appartement de standing', price:'850 000', location:'Les Berges du Lac II', details:'3 ch • 2 sdb • 145 m²'),
                PropertyCard(image:'villa.jpg', title:'Penthouse Panoramique', price:'920 000', location:'Carthage, Tunis', details:'3 ch • 3 sdb • 210 m²'),
              ],
            ),
          )),
          const SliverToBoxAdapter(child: SectionHeader('Biens à proximité', '< 5 km')),
          SliverToBoxAdapter(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: const [
              NearbyCard(image:'duplex.jpg', price:'580 000', title:'Duplex avec Jardin Privatif', location:'El Menzah 9, Tunis', tag:'Nouveau'),
              SizedBox(height:10),
              NearbyCard(image:'apartment.jpg', price:'390 000', title:'S+2 Haut Standing Neuf', location:'Ariana Ville', tag:''),
            ]),
          )),
          const SliverToBoxAdapter(child: SectionHeader('Biens sur la carte', 'Grand Tunis')),
          SliverToBoxAdapter(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MapPage())),
              child: ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.asset('assets/map.jpg', height: 170, width: double.infinity, fit: BoxFit.cover)),
            ),
          )),
          SliverToBoxAdapter(child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
            child: Container(
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(color: C.navy, borderRadius: BorderRadius.circular(15)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('▣ ESPACE PROPRIÉTAIRE', style: TextStyle(color: C.amber, fontSize: 9, fontWeight: FontWeight.w800)),
                const SizedBox(height: 7),
                const Text('Vous êtes propriétaire ?', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
                const SizedBox(height: 5),
                const Text('Publiez votre bien en vente ou location en 2 minutes et touchez des acheteurs qualifiés.', style: TextStyle(color: Color(0xFFB3C9E0), fontSize: 9, height: 1.5)),
                const SizedBox(height: 10),
                FilledButton.icon(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PublishPage())),
                  icon: const Icon(Icons.add_circle_outline, size: 16),
                  label: const Text('Déposer une annonce'),
                  style: FilledButton.styleFrom(backgroundColor: C.amber, foregroundColor: Colors.white),
                ),
              ]),
            ),
          )),
        ],
      ),
    );
  }
}
