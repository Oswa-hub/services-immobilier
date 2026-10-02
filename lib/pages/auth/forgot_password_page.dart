import 'package:flutter/material.dart';
import '../../core/app_theme.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Mot de passe oublié ?', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900, color: C.navy)),
          const SizedBox(height: 8),
          const Text('Entrez votre email et nous vous enverrons un lien de récupération.', style: TextStyle(color: C.muted)),
          const SizedBox(height: 28),
          const TextField(decoration: InputDecoration(labelText: 'Adresse email', prefixIcon: Icon(Icons.mail_outline))),
          const SizedBox(height: 18),
          SizedBox(width: double.infinity, child: FilledButton(onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lien de récupération envoyé.')));
          }, style: FilledButton.styleFrom(backgroundColor: C.navy, padding: const EdgeInsets.symmetric(vertical: 15)), child: const Text('Envoyer le lien'))),
        ]),
      ),
    );
  }
}
