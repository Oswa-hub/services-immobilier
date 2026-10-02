import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../pages/main/search_page.dart';

class AppBarSimple extends StatelessWidget {
  final String title;
  final bool back;
  const AppBarSimple(this.title, {super.key, this.back = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        children: [
          if (back) const BackButton(),
          if (!back) const SizedBox(width: 4),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: C.text))),
          if (!back) IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded)),
        ],
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  final VoidCallback? onTap;
  const SearchBox({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchPage())),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: C.line),
        ),
        child: const Row(
          children: [
            Icon(Icons.search_rounded, color: C.secondary),
            SizedBox(width: 9),
            Expanded(child: Text('Rechercher une ville, un quartier...', style: TextStyle(color: C.muted, fontSize: 12))),
            Icon(Icons.tune_rounded, color: C.text),
          ],
        ),
      ),
    );
  }
}

class FilterPill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  const FilterPill(this.label, {super.key, this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 7),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? C.navy : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? C.navy : C.line),
        ),
        child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: selected ? Colors.white : C.text)),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String action;
  const SectionHeader(this.title, this.action, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 9),
      child: Row(
        children: [
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: C.text))),
          Text(action, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: C.secondary)),
        ],
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String location;
  final String details;
  const PropertyCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.location,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 285,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: C.line),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset('assets/$image', height: 125, width: double.infinity, fit: BoxFit.cover),
              Positioned(
                top: 9, right: 9,
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(.92), shape: BoxShape.circle),
                  child: const Icon(Icons.favorite_border_rounded, size: 17),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 9, 12, 11),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
              const SizedBox(height: 3),
              Text(location, style: const TextStyle(color: C.muted, fontSize: 9)),
              const SizedBox(height: 8),
              Row(children: [
                Text('$price TND', style: const TextStyle(color: C.navy, fontWeight: FontWeight.w900, fontSize: 12)),
                const Spacer(),
                Text(details, style: const TextStyle(color: C.muted, fontSize: 8)),
              ]),
            ]),
          ),
        ],
      ),
    );
  }
}

class NearbyCard extends StatelessWidget {
  final String image, price, title, location, tag;
  const NearbyCard({super.key, required this.image, required this.price, required this.title, required this.location, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: C.line)),
      child: Row(children: [
        ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset('assets/$image', width: 86, height: 78, fit: BoxFit.cover)),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (tag.isNotEmpty) Text(tag, style: const TextStyle(color: C.green, fontSize: 8, fontWeight: FontWeight.w800)),
          Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
          const SizedBox(height: 3),
          Text(location, style: const TextStyle(color: C.muted, fontSize: 9)),
          const SizedBox(height: 6),
          Text('$price TND', style: const TextStyle(color: C.navy, fontWeight: FontWeight.w900, fontSize: 11)),
        ])),
        const Icon(Icons.chevron_right_rounded, color: C.muted),
      ]),
    );
  }
}

class BottomNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;
  const BottomNav({super.key, required this.index, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    const items = [
      (Icons.home_rounded, 'Accueil'),
      (Icons.search_rounded, 'Recherche'),
      (Icons.map_outlined, 'Carte'),
      (Icons.favorite_border_rounded, 'Favoris'),
      (Icons.person_outline_rounded, 'Profil'),
    ];
    return NavigationBar(
      selectedIndex: index,
      onDestinationSelected: onChanged,
      height: 66,
      destinations: [
        for (final item in items) NavigationDestination(icon: Icon(item.$1), label: item.$2),
      ],
    );
  }
}
