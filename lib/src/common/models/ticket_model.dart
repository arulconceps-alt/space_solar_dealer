class TicketModel {
  final String ticketId;
  final String ticketNumber;
  final String customerName;
  final String status;
  final String issue;
  final String description;
  final String date;
  final String priority;
  final String category;

  TicketModel({
    required this.ticketId,
    required this.ticketNumber,
    required this.customerName,
    required this.status,
    required this.issue,
    required this.description,
    required this.date,
    required this.priority,
    required this.category,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      ticketId: json["id"] ?? "",
      ticketNumber: json["ticketNumber"] ?? "",
      customerName: json["customer"]?["name"] ?? "",   // ✅ nested
      status: json["status"] ?? "",
      issue: json["title"] ?? "",                      // ✅ mapped
      description: json["description"] ?? "",
      date: json["createdAt"] ?? "",                   // ✅ use createdAt
      priority: json["priority"] ?? "",
      category: json["category"] ?? "",
    );
  }
}