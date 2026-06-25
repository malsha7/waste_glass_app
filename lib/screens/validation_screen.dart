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

  Future<void> validate() async {

    setState(() {
      loading = true;
      message = "";
      supplier = null;
    });

    try {
      final result = await ApiService.validateSupplier(controller.text);

      setState(() {
        supplier = result;
        message = "Supplier Found ✅";
      });

    } catch (e) {
      setState(() {
        message = "Invalid Supplier ❌";
      });
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Supplier Validation")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Enter Supplier Code",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : validate,
                child: const Text("Validate"),
              ),
            ),

            const SizedBox(height: 20),

            if (loading) const CircularProgressIndicator(),

            if (message.isNotEmpty)
              Text(message),

            const SizedBox(height: 20),

            if (supplier != null)
              Card(
                child: ListTile(
                  title: Text(supplier!.name),
                  subtitle: Text(supplier!.supplierCode),
                  trailing: Text(supplier!.status),
                ),
              ),
          ],
        ),
      ),
    );
  }
}