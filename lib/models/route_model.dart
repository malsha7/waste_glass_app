class RouteStop {
  final int supplierId;
  final String name;
  final double latitude;
  final double longitude;
  final double distanceFromPrevious;

  RouteStop({
    required this.supplierId,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.distanceFromPrevious,
  });

  factory RouteStop.fromJson(Map<String, dynamic> json) {
    return RouteStop(
      supplierId: json['supplierId'],
      name: json['name'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      distanceFromPrevious:
          (json['distanceFromPrevious'] as num).toDouble(),
    );
  }
}