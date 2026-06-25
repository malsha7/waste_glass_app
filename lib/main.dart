import 'package:flutter/material.dart';
import 'screens/screen1_trip.dart';

void main() {
  runApp(const WasteGlassApp());
}

class WasteGlassApp extends StatelessWidget {
  const WasteGlassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Waste Glass Collection',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const Screen1Trip(),
    );
  }
}