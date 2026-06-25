import 'package:flutter/material.dart';
import 'validation_screen.dart';
import 'collection_screen.dart';
import 'route_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Waste Glass System"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            _menuButton(
              context,
              "Validate Supplier",
              Icons.qr_code,
              const ValidationScreen(),
            ),

            const SizedBox(height: 15),

            _menuButton(
              context,
              "Collection Entry",
              Icons.add_box,
              const CollectionScreen(),
            ),

            const SizedBox(height: 15),

            _menuButton(
              context,
              "Route & Report",
              Icons.map,
              const RouteScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuButton(
    BuildContext context,
    String title,
    IconData icon,
    Widget page,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(title),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
      ),
    );
  }
}