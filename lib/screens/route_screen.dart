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

  bool loading = true;

  static const Color darkBlue = Color(0xFF0D47A1);

  Future<void> loadData() async {
    try {
      final r1 = await ApiService.getRoute();
      final r2 = await ApiService.getTripReport();

      setState(() {
        route = r1;
        report = r2;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Widget statCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: darkBlue, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: darkBlue,
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 12),
            ),
          ],
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
          "Route & Analytics",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ================= Header =================
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
                        Icon(Icons.map, color: Colors.white, size: 32),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Collection Route & Trip Analytics",
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

                  // ================= Statics =================
                  Row(
                    children: [
                      statCard(
                        "Total Distance",
                        "${route?.totalDistance ?? 0} km",
                        Icons.route,
                      ),
                      const SizedBox(width: 10),
                      statCard(
                        "Suppliers",
                        "${report?.totalSuppliers ?? 0}",
                        Icons.people,
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      statCard(
                        "Expected KG",
                        "${report?.totalExpectedKg ?? 0}",
                        Icons.arrow_downward,
                      ),
                      const SizedBox(width: 10),
                      statCard(
                        "Collected KG",
                        "${report?.totalCollectedKg ?? 0}",
                        Icons.check_circle,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Route Stops",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: darkBlue,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ================= Route List =================
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: route?.route.length ?? 0,
                    itemBuilder: (context, index) {
                      final stop = route!.route[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: darkBlue.withOpacity(0.1),
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: darkBlue,
                              child: Text(
                                "${index + 1}",
                                style: const TextStyle(
                                    color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    stop.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Distance: ${stop.distanceFromPrevious} km",
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.location_on,
                                color: Colors.grey),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}