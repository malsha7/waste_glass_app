class TripReport {
  final int totalSuppliers;
  final double totalExpectedKg;
  final double totalCollectedKg;

  TripReport({
    required this.totalSuppliers,
    required this.totalExpectedKg,
    required this.totalCollectedKg,
  });

  factory TripReport.fromJson(Map<String, dynamic> json) {
    return TripReport(
      totalSuppliers: json['totalSuppliers'],
      totalExpectedKg:
          (json['totalExpectedKg'] as num).toDouble(),
      totalCollectedKg:
          (json['totalCollectedKg'] as num).toDouble(),
    );
  }
}