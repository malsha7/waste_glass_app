import 'package:flutter/material.dart';
import '../models/route_model.dart';
import '../models/trip_report.dart';
import '../services/api_service.dart';

class RouteScreen extends StatefulWidget {
  const RouteScreen({super.key});

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {

  RouteResponse? route;
  TripReport? report;

  bool loading = false;

  Future<void> loadData() async {

    setState(() => loading = true);

    try {
      final r1 = await ApiService.getRoute();
      final r2 = await ApiService.getTripReport();

      setState(() {
        route = r1;
        report = r2;
      });

    } catch (e) {
      // optional error handling
    }

    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Route & Report")),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ================= ROUTE =================
                  Text(
                    "Route (Total: ${route?.totalDistance ?? 0} km)",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Expanded(
                    child: ListView.builder(
                      itemCount: route?.route.length ?? 0,
                      itemBuilder: (context, index) {

                        final stop = route!.route[index];

                        return Card(
                          child: ListTile(
                            title: Text(stop.name),
                            subtitle: Text(
                              "Distance: ${stop.distanceFromPrevious} km",
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ================= REPORT =================
                  if (report != null)
                    Card(
                      color: Colors.blue.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text("Trip Report",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),

                            Text("Suppliers: ${report!.totalSuppliers}"),
                            Text("Expected KG: ${report!.totalExpectedKg}"),
                            Text("Collected KG: ${report!.totalCollectedKg}"),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}