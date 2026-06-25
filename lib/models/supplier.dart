class Supplier {
  final int id;
  final String supplierCode;
  final String name;
  final String status;

  Supplier({
    required this.id,
    required this.supplierCode,
    required this.name,
    required this.status,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['id'],
      supplierCode: json['supplierCode'],
      name: json['name'],
      status: json['status'] ?? '',
    );
  }
}