
class RouteResponse {

final double totalDistance;
final List<RouteStop> route;


RouteResponse({

required this.totalDistance,
required this.route

});


factory RouteResponse.fromJson(Map<String,dynamic> json){

return RouteResponse(

totalDistance:
(json['totalDistance'] as num).toDouble(),


route:
(json['route'] as List)
.map((e)=>RouteStop.fromJson(e))
.toList()

);

}

}


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