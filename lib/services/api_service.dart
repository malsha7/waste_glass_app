import 'dart:convert';
import 'package:http/http.dart' as http;


class ApiService {
  static const String baseUrl =
      "https://wasteglassapi-pvvm.onrender.com";


 // =========================
   //  Get all suppliers
 // =========================
   static Future<List<dynamic>> getSuppliers() async {
     final response = await http.get(
       Uri.parse("$baseUrl/api/suppliers"),
     );

     if (response.statusCode == 200) {
       return jsonDecode(response.body);
     } else {
       throw Exception("Failed to load suppliers");
     }
   }

 // =========================
  // Submit collections
 // =========================
  static Future<Map<String, dynamic>> submitCollection(
      Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/collections"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to submit collection");
    }
  }

 // =========================
  //  Get supplier by id
 // =========================
  static Future<Map<String, dynamic>> getSupplierById(
      String id) async {
    final response = await http.get(
      Uri.parse("$baseUrl/api/suppliers/$id"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Supplier not found");
    }
  }

 // =========================
  //  Barcode validation
 // =========================
  static Future<Map<String, dynamic>> validateSupplier(
      String code) async {
    final response = await http.get(
      Uri.parse("$baseUrl/api/suppliers/validate/$code"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Invalid barcode / supplier not found");
    }
  }

 // =========================
  //  Route /trip sequence
 // =========================
  static Future<List<dynamic>> getRoute() async {
    final response = await http.get(
      Uri.parse("$baseUrl/api/route"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load route data");
    }
  }

 // =========================
  //  Trip report
 // =========================
  static Future<Map<String, dynamic>> getTripReport() async {
    final response = await http.get(
      Uri.parse("$baseUrl/api/trip/report"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load trip report");
    }

}

