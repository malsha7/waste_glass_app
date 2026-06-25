class Collection {
  final int supplierId;
  final double clearGlassKg;
  final double colouredGlassKg;

  Collection({
    required this.supplierId,
    required this.clearGlassKg,
    required this.colouredGlassKg,
  });

  Map<String, dynamic> toJson() {
    return {
      "supplierId": supplierId,
      "clearGlassKg": clearGlassKg,
      "colouredGlassKg": colouredGlassKg,
    };
  }
}