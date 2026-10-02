import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import 'login_page.dart';
import 'register_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Center(child: Container(
                width: 92, height: 92,
                decoration: BoxDecoration(color: C.navy, borderRadius: BorderRadius.circular(28)),
                child: const Icon(Icons.home_work_rounded, color: Colors.white, size: 48),
              )),
              const SizedBox(height: 26),
              const Center(child: Text('ImmoFind', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: C.navy))),
              const SizedBox(height: 8),
              const Center(child: Text('Trouvez votre résidence en Tunisie', textAlign: TextAlign.center, style: TextStyle(color: C.muted, fontSize: 13))),
              const Spacer(),
              SizedBox(width: double.infinity, child: FilledButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage())),
                style: FilledButton.styleFrom(backgroundColor: C.navy, padding: const EdgeInsets.symmetric(vertical: 15)),
                child: const Text('Se connecter'),
              )),
              const SizedBox(height: 10),
              SizedBox(width: double.infinity, child: OutlinedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())),
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15)),
                child: const Text('Créer un compte'),
              )),
              const SizedBox(height: 18),
              const Center(child: Text('Vente • Location • Recherche • Carte', style: TextStyle(fontSize: 10, color: C.muted))),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
