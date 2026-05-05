class TicketCreateResponse {
  final String id;
  final String ticketNumber;
  final String status;

  TicketCreateResponse({
    required this.id,
    required this.ticketNumber,
    required this.status,
  });

  factory TicketCreateResponse.fromJson(Map<String, dynamic> json) {
    return TicketCreateResponse(
      id: json["id"],
      ticketNumber: json["ticketNumber"],
      status: json["status"],
    );
  }
}