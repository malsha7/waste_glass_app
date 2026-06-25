import 'package:flutter/material.dart';
import 'validation_screen.dart';
import 'collection_screen.dart';
import 'route_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color darkBlue = Color(0xFF0D47A1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: darkBlue,
        title: const Text(
          "Waste Glass System",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
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
      height: 55,

      child: ElevatedButton.icon(
        icon: Icon(icon, color: darkBlue),

        label: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF0D47A1), // dark blue text
            fontWeight: FontWeight.w600,
          ),
        ),

        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(
              color: Color(0xFF0D47A1),
              width: 1.5,
            ),
          ),
        ),

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