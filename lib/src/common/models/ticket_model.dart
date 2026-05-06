class TicketModel {
  final String ticketId;
  final String ticketNumber;
  final String customerName;
  final String status;
  final String issue;
  final String description;
  final String priority;
  final String category;
  final String panelId;
  final DateTime createdAt;
  final String email;
final String phone;
final String addressLine1;  

  TicketModel({
  required this.ticketId,
  required this.ticketNumber,
  required this.customerName,
  required this.status,
  required this.issue,
  required this.description,
  required this.priority,
  required this.category,
  required this.panelId,
  required this.createdAt,
  required this.email,
  required this.phone,
  required this.addressLine1,
});

 factory TicketModel.fromJson(Map<String, dynamic> json) {
  try {
    final customer = json["customer"];
    final products = json["products"];

    String panelId = "-";

    if (products != null && products is List && products.isNotEmpty) {
      panelId = products[0]?["serialNo"] ?? "-";
    } else if (customer != null &&
        customer["soldSerials"] != null &&
        customer["soldSerials"] is List &&
        customer["soldSerials"].isNotEmpty) {
      final panels = customer["soldSerials"];
      panelId = panels.first["serialNumber"] ?? "-";
    }

    return TicketModel(
      ticketId: json["id"] ?? "",
      ticketNumber: json["ticketNumber"] ?? "",
      customerName: customer?["name"] ?? "N/A",
      status: json["status"] ?? "",
      issue: json["title"] ?? "",
      description: json["description"] ?? "",
      priority: json["priority"] ?? "",
      category: json["category"] ?? "",
      panelId: panelId,
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"]).toLocal()
          : DateTime.now(),

      /// ✅ NEW FIELDS
      email: customer?["email"] ?? "",
      phone: (customer?["phone"] ?? "").toString().replaceAll("+91", ""),
      addressLine1: customer?["addressLine1"] ?? "",
    );
  } catch (e, stack) {
    print("❌ MODEL ERROR: $e");
    print("❌ STACK: $stack");
    print("❌ FAILED JSON: $json");
    rethrow;
  }
}
}