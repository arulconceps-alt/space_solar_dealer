class CustomerModel {
  final String id;
  final String name;
  final String phone;
  final String address;

  CustomerModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      address: json["address"] ?? "",
    );
  }
}