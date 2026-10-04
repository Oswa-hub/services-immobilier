import 'package:flutter/material.dart';
import '../../core/app_theme.dart';
import '../main/main_shell.dart';
import 'forgot_password_page.dart';
import 'register_page.dart';
import '../../features/admin/presentation/admin_login_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  @override void dispose(){email.dispose(); password.dispose(); super.dispose();}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: ListView(padding: const EdgeInsets.fromLTRB(22, 10, 22, 30), children: [
        const Text('Bon retour 👋', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: C.navy)),
        const SizedBox(height: 6),
        const Text('Connectez-vous pour retrouver vos recherches.', style: TextStyle(color: C.muted)),
        const SizedBox(height: 30),
        TextField(controller: email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.mail_outline))),
        const SizedBox(height: 14),
        TextField(controller: password, obscureText: true, decoration: const InputDecoration(labelText: 'Mot de passe', prefixIcon: Icon(Icons.lock_outline))),
        Align(alignment: Alignment.centerRight, child: TextButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordPage())),
          child: const Text('Mot de passe oublié ?'),
        )),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const MainShell()), (_) => false),
          style: FilledButton.styleFrom(backgroundColor: C.navy, padding: const EdgeInsets.symmetric(vertical: 15)),
          child: const Text('Se connecter'),
        ),
        const SizedBox(height: 18),
        Row(children: [const Expanded(child: Divider()), const Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('ou')), const Expanded(child: Divider())]),
        const SizedBox(height: 18),
        OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.g_mobiledata_rounded), label: const Text('Continuer avec Google')),
        const SizedBox(height: 18),
        Center(child: TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())), child: const Text('Pas encore de compte ? Créer un compte'))),
        Center(child: TextButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminLoginPage())), icon: const Icon(Icons.admin_panel_settings_outlined, size: 18), label: const Text('Espace administrateur'))),
      ]),
    );
  }
}
