import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../auth/welcome_page.dart';
import 'publish_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override Widget build(BuildContext context) => SafeArea(child: ListView(padding: const EdgeInsets.fromLTRB(16, 8, 16, 25), children: [
    const Text('Profil', style: TextStyle(fontSize:19, fontWeight:FontWeight.w800)),
    const SizedBox(height:18),
    const Center(child: CircleAvatar(radius:42, backgroundImage: AssetImage('assets/avatar.png'))),
    const SizedBox(height:10),
    const Center(child: Text('Karim Ben Ali', style: TextStyle(fontSize:16, fontWeight:FontWeight.w800))),
    const SizedBox(height:4),
    const Center(child: Text('karim@example.com', style: TextStyle(fontSize:10, color:C.muted))),
    const SizedBox(height:24),
    Card(child: Column(children: [
      ListTile(leading: const Icon(Icons.person_outline), title: const Text('Informations personnelles'), trailing: const Icon(Icons.chevron_right)),
      ListTile(leading: const Icon(Icons.notifications_none), title: const Text('Notifications'), trailing: const Icon(Icons.chevron_right)),
      ListTile(leading: const Icon(Icons.add_home_work_outlined), title: const Text('Mes annonces'), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PublishPage()))),
      ListTile(leading: const Icon(Icons.settings_outlined), title: const Text('Paramètres'), trailing: const Icon(Icons.chevron_right)),
    ])),
    const SizedBox(height:12),
    OutlinedButton.icon(onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const WelcomePage()), (_) => false), icon: const Icon(Icons.logout), label: const Text('Se déconnecter')),
  ]));
}
