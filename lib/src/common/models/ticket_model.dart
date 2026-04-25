class TicketModel {
  final String ticketId;
  final String customerName;
  final String status;
  final String issue;
  final String panelId;
  final String date;
  final String sla;

  TicketModel({
    required this.ticketId,
    required this.customerName,
    required this.status,
    required this.issue,
    required this.panelId,
    required this.date,
    required this.sla,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      ticketId: json["ticketId"] ?? "",
      customerName: json["customerName"] ?? "",
      status: json["status"] ?? "",
      issue: json["issue"] ?? "",
      panelId: json["panelId"] ?? "",
      date: json["date"] ?? "",
      sla: json["sla"] ?? "",
    );
  }
}