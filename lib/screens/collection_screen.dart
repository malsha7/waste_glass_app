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

  static const Color darkBlue = Color(0xFF0D47A1);

  Future<void> submitData() async {

    setState(() {
      loading = true;
      message = "";
    });

    final collection = Collection(
      supplierId: int.tryParse(supplierController.text) ?? 0,
      clearGlassKg: double.tryParse(clearController.text) ?? 0,
      colouredGlassKg: double.tryParse(colouredController.text) ?? 0,
    );

    final result =
        await ApiService.submitCollection(collection.toJson());

    setState(() {
      loading = false;
      message = result
          ? "Collection Submitted Successfully"
          : "Submission Failed";
    });
  }

  Widget buildField(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: darkBlue),
          decoration: InputDecoration(
            icon: Icon(icon, color: darkBlue),
            labelText: label,
            labelStyle: const TextStyle(color: darkBlue),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: darkBlue,
        title: const Text(
          "Collection Entry",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            buildField("Supplier ID", supplierController, Icons.person),
            const SizedBox(height: 10),

            buildField("Clear Glass KG", clearController, Icons.water_drop),
            const SizedBox(height: 10),

            buildField("Coloured Glass KG", colouredController, Icons.color_lens),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(
                onPressed: loading ? null : submitData,

                style: ElevatedButton.styleFrom(
                  backgroundColor: darkBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),

                child: Text(
                  loading ? "Submitting..." : "Submit Collection",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (loading)
              const CircularProgressIndicator(color: darkBlue),

            const SizedBox(height: 10),

            if (message.isNotEmpty)
              Text(
                message,
                style: TextStyle(
                  color: message.contains("Success")
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}