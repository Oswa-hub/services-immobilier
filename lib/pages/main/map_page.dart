import 'package:flutter/material.dart';
import '../../core/app_theme.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  Widget mapBtn(IconData icon) => Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.10),
              blurRadius: 8,
            ),
          ],
        ),
        child: Icon(icon, size: 19, color: C.navy),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 5, 12, 5),
              child: Row(
                children: [
                  const BackButton(),
                  const Expanded(
                    child: Text(
                      'Biens sur la carte',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Liste'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/map.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 14,
                    left: 12,
                    right: 12,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (final x in [
                            'Prix < 900k TND',
                            '3+ Chambres',
                            'Villas',
                            'Piscine',
                            'Certifiés',
                          ])
                            Container(
                              margin: const EdgeInsets.only(right: 6),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(17),
                              ),
                              child: Text(
                                x,
                                style: const TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 70,
                    child: Column(
                      children: [
                        mapBtn(Icons.my_location),
                        const SizedBox(height: 7),
                        mapBtn(Icons.add),
                        const SizedBox(height: 7),
                        mapBtn(Icons.remove),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 15,
                    child: Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.12),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/villa.jpg',
                            width: 65,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ImmoFind Certifié',
                                  style: TextStyle(
                                    color: C.green,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  'La Marsa Plage',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  'Villa d’Architecte & Piscine',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: C.muted,
                                  ),
                                ),
                                Text(
                                  '1 250 000 TND • 4 ch • 320 m²',
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
