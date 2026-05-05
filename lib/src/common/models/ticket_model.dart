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
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    try {
      print("📦 RAW JSON: $json");

      final customer = json["customer"];
      final products = json["products"];

      print("👉 customer: $customer");
      print("👉 products: $products");

      String panelId = "-";

      if (products != null && products is List && products.isNotEmpty) {
        print("👉 products[0]: ${products[0]}");
        panelId = products[0]?["serialNo"] ?? "-";
      } else if (customer != null &&
          customer["soldSerials"] != null &&
          customer["soldSerials"] is List &&
          customer["soldSerials"].isNotEmpty) {

        final panels = customer["soldSerials"];
        print("👉 panels: $panels");

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
      );

    } catch (e, stack) {
      print("❌ MODEL ERROR: $e");
      print("❌ STACK: $stack");
      print("❌ FAILED JSON: $json");
      rethrow;
    }
  }
}