import 'package:flutter/material.dart';
import '../models/collection.dart';
import '../services/api_service.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {

  final supplierController = TextEditingController();
  final clearController = TextEditingController();
  final colouredController = TextEditingController();

  bool loading = false;
  String message = "";

  Future<void> submitData() async {

    setState(() {
      loading = true;
      message = "";
    });

    // ✅ USING YOUR EXISTING MODEL ONLY
    final collection = Collection(
      supplierId: int.tryParse(supplierController.text) ?? 0,
      clearGlassKg: double.tryParse(clearController.text) ?? 0,
      colouredGlassKg: double.tryParse(colouredController.text) ?? 0,
    );

    // ❗ NO SERVICE CHANGE (uses your existing method name)
    final result = await ApiService.submitCollection(collection.toJson());

    setState(() {
      loading = false;
      message = result
          ? "Collection Submitted Successfully "
          : "Submission Failed ";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Collection Entry"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: supplierController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Supplier ID",
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: clearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Clear Glass KG",
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: colouredController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Coloured Glass KG",
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : submitData,
                child: const Text("Submit Collection"),
              ),
            ),

            const SizedBox(height: 20),

            if (loading)
              const CircularProgressIndicator(),

            const SizedBox(height: 10),

            Text(
              message,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}