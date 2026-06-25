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

  Widget inputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: darkBlue.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: darkBlue,
        title: const Text(
          "Collection Entry",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ================= HEADER =================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(Icons.recycling, color: Colors.white, size: 32),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Record Glass Collection Data",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ================= INPUTS =================
            inputField(
              label: "Supplier ID",
              controller: supplierController,
              icon: Icons.person,
            ),

            inputField(
              label: "Clear Glass KG",
              controller: clearController,
              icon: Icons.water_drop,
            ),

            inputField(
              label: "Coloured Glass KG",
              controller: colouredController,
              icon: Icons.color_lens,
            ),

            const SizedBox(height: 10),

            // ================= BUTTON =================
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: loading ? null : submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Submit Collection",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 15),

            // ================= STATUS =================
            if (message.isNotEmpty)
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: message.contains("Success")
                        ? Colors.green.shade100
                        : Colors.red.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: message.contains("Success")
                          ? Colors.green.shade800
                          : Colors.red.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}