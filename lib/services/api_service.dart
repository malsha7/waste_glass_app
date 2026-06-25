import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/supplier.dart';
import '../models/route_model.dart';
import '../models/trip_report.dart';

class ApiService {

  static const String baseUrl =
      "https://wasteglassapi-pvvm.onrender.com";

  // =========================
  // Get all suppliers
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
  // Submit collection
  // =========================
  static Future<bool> submitCollection(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/collections"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  // =========================
  // Validate supplier
  // =========================
  static Future<Supplier> validateSupplier(String code) async {
    final response = await http.get(
      Uri.parse("$baseUrl/api/suppliers/validate/$code"),
    );

    if (response.statusCode == 200) {
      return Supplier.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Invalid barcode / supplier not found");
    }
  }

  // =========================
  // Route
  // =========================
  static Future<RouteResponse> getRoute() async {
    final response = await http.get(
      Uri.parse("$baseUrl/api/route"),
    );

    if (response.statusCode == 200) {
      return RouteResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load route data");
    }
  }

  // =========================
  // Trip report
  // =========================
  static Future<TripReport> getTripReport() async {
    final response = await http.get(
      Uri.parse("$baseUrl/api/trip/report"),
    );

    if (response.statusCode == 200) {
      return TripReport.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load trip report");
    }
  }
}