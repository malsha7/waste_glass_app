import 'package:flutter/material.dart';
import '../models/supplier.dart';
import '../services/api_service.dart';

class ValidationScreen extends StatefulWidget {
  const ValidationScreen({super.key});

  @override
  State<ValidationScreen> createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  final controller = TextEditingController();

  Supplier? supplier;
  bool loading = false;
  String message = "";

  static const Color darkBlue = Color(0xFF0D47A1);

  Future<void> validate() async {
    setState(() {
      loading = true;
      message = "";
      supplier = null;
    });

    try {
      final result =
          await ApiService.validateSupplier(controller.text);

      setState(() {
        supplier = result;
        message = "Supplier Found";
      });
    } catch (e) {
      setState(() {
        message = "Invalid Supplier";
      });
    }

    setState(() => loading = false);
  }

  Widget inputBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: darkBlue.withOpacity(0.2)),
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
        style: const TextStyle(color: darkBlue),
        decoration: const InputDecoration(
          icon: Icon(Icons.qr_code, color: darkBlue),
          labelText: "Enter Supplier Code",
          labelStyle: TextStyle(color: darkBlue),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget statusMessage() {
    if (message.isEmpty) return const SizedBox();

    final isSuccess = message.contains("Found");

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isSuccess
            ? Colors.green.shade100
            : Colors.red.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isSuccess
              ? Colors.green.shade800
              : Colors.red.shade800,
          fontWeight: FontWeight.bold,
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
          "Supplier Validation",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header Card
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
                  Icon(Icons.verified_user,
                      color: Colors.white, size: 32),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Validate Supplier Barcode",
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

            inputBox(),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 52,

              child: ElevatedButton(
                onPressed: loading ? null : validate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Validate Supplier",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            statusMessage(),

            const SizedBox(height: 20),

            if (supplier != null)
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: darkBlue,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(
                    supplier!.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(supplier!.supplierCode),
                  trailing: Text(
                    supplier!.status,
                    style: TextStyle(
                      color: supplier!.status == "OK"
                          ? Colors.green
                          : Colors.orange,
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