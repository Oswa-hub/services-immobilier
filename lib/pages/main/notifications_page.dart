import 'package:flutter/material.dart';
import '../../core/app_theme.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Notifications')),
    body: ListView(padding: const EdgeInsets.all(16), children: const [
      ListTile(leading: CircleAvatar(child: Icon(Icons.home_work_outlined)), title: Text('Nouveau bien disponible'), subtitle: Text('Un appartement correspondant à votre recherche vient d’être ajouté.')),
      ListTile(leading: CircleAvatar(child: Icon(Icons.favorite_border)), title: Text('Prix mis à jour'), subtitle: Text('Un bien enregistré dans vos favoris a changé de prix.')),
      ListTile(leading: CircleAvatar(child: Icon(Icons.location_on_outlined)), title: Text('Nouvelle zone'), subtitle: Text('De nouveaux biens sont disponibles près de Tunis.')),
    ]),
  );
}
