import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';
import 'home_page.dart';
import 'search_page.dart';
import 'map_page.dart';
import 'favorites_page.dart';
import 'profile_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;
  final pages = const [HomePage(), SearchPage(), MapPage(), FavoritesPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: BottomNav(index: index, onChanged: (i) => setState(() => index = i)),
    );
  }
}
