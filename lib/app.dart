import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'pages/auth/welcome_page.dart';

class ImmoFindApp extends StatelessWidget {
  const ImmoFindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ImmoFind',
      theme: AppTheme.light,
      home: const WelcomePage(),
    );
  }
}
