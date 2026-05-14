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
  final String assignedToName;
  final List<Map<String, dynamic>> statusHistory;
  final int totalWorkedInMinutes;
  final List<String> dealerAttachments;
  final List<String> technicianAttachments;
  final String? resolutionNote;
final String? revisitDate;

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
    required this.assignedToName,
    this.statusHistory = const [],
    this.totalWorkedInMinutes = 0,
    this.dealerAttachments = const [],
    this.technicianAttachments = const [],
    this.resolutionNote,
this.revisitDate,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    final customer = json["customer"];
    final assignedTo = json["assignedTo"];
    final products = json["products"];

    String panelId = "-";

    if (products is List && products.isNotEmpty) {
      panelId = products
          .map((e) => e["serialNo"]?.toString() ?? "")
          .where((e) => e.isNotEmpty)
          .join(",");
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
      email: customer?["email"] ?? "",
      phone: (customer?["phone"] ?? "").toString().replaceAll("+91", ""),
      addressLine1: customer?["addressLine1"] ?? "",
      assignedToName: assignedTo?["name"] ?? "",
      statusHistory: List<Map<String, dynamic>>.from(json["statusHistory"] ?? []),
      totalWorkedInMinutes: json["totalWorkedInMinutes"] ?? 0,
      dealerAttachments:
          List<String>.from(json["dealerAttachments"] ?? []),

      technicianAttachments:
          List<String>.from(json["technicianAttachments"] ?? []),
          resolutionNote: json["resolutionNote"],
revisitDate: json["revisitDate"],
    );
  }
}