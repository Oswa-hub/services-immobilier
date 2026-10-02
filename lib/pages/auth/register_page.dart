import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../main/main_shell.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: ListView(padding: const EdgeInsets.fromLTRB(22, 10, 22, 30), children: [
        const Text('Créer un compte', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: C.navy)),
        const SizedBox(height: 6),
        const Text('Commencez à sauvegarder vos biens favoris.', style: TextStyle(color: C.muted)),
        const SizedBox(height: 28),
        const TextField(decoration: InputDecoration(labelText: 'Nom complet', prefixIcon: Icon(Icons.person_outline))),
        const SizedBox(height: 13),
        const TextField(decoration: InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.mail_outline))),
        const SizedBox(height: 13),
        const TextField(obscureText: true, decoration: InputDecoration(labelText: 'Mot de passe', prefixIcon: Icon(Icons.lock_outline))),
        const SizedBox(height: 22),
        FilledButton(onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const MainShell()), (_) => false),
          style: FilledButton.styleFrom(backgroundColor: C.navy, padding: const EdgeInsets.symmetric(vertical: 15)),
          child: const Text('Créer mon compte')),
      ]),
    );
  }
}
