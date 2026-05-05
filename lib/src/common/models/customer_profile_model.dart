class CustomerProfile {
  final String customerCode;
  final String propertyType;
  final String rooftopArea;
  final String electricityBill;

  CustomerProfile({
    required this.customerCode,
    required this.propertyType,
    required this.rooftopArea,
    required this.electricityBill,
  });

  factory CustomerProfile.fromJson(Map<String, dynamic> json) {
    return CustomerProfile(
      customerCode: json['customerCode'] ?? '',
      propertyType: json['propertyType'] ?? '',
      rooftopArea: json['rooftopArea'] ?? '',
      electricityBill: json['electricityBill'] ?? '',
    );
  }
}