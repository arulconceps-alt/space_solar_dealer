class OrderResponse {
  final String id;
  final String orderNumber;
  final String userId;
  final String dealerId;
  final String status;
  final String totalAmount;

  OrderResponse({
    required this.id,
    required this.orderNumber,
    required this.userId,
    required this.dealerId,
    required this.status,
    required this.totalAmount,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      id: json['id'] ?? '',
      orderNumber: json['orderNumber'] ?? '',
      userId: json['userId'] ?? '',
      dealerId: json['dealerId'] ?? '',
      status: json['status'] ?? '',
      totalAmount: json['totalAmount']?.toString() ?? '0',
    );
  }
}