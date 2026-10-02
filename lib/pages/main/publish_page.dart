import 'package:flutter/material.dart';
import '../../core/app_theme.dart';

class PublishPage extends StatelessWidget {
  const PublishPage({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Déposer une annonce')),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      Container(height: 145, decoration: BoxDecoration(color: const Color(0xFFE8F0F4), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.add_a_photo_outlined, size: 42, color: C.secondary)),
      const SizedBox(height: 16),
      const TextField(decoration: InputDecoration(labelText:'Titre de l’annonce')),
      const SizedBox(height: 12),
      const TextField(decoration: InputDecoration(labelText:'Localisation')),
      const SizedBox(height: 12),
      const TextField(decoration: InputDecoration(labelText:'Prix (TND)')),
      const SizedBox(height: 12),
      const TextField(maxLines:4, decoration: InputDecoration(labelText:'Description')),
      const SizedBox(height: 18),
      FilledButton(onPressed: () => Navigator.pop(context), style: FilledButton.styleFrom(backgroundColor: C.navy, padding: const EdgeInsets.symmetric(vertical: 15)), child: const Text('Publier l’annonce')),
    ]),
  );
}
