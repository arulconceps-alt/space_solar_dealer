class PanelModel {
  final int productId;
  final String productName;
  final String serialNumber;
  final String orderNumber;
  final DateTime? soldAt;

  final String customerId;
  final String customerName;
  final String customerPhone;

  PanelModel({
    required this.productId,
    required this.productName,
    required this.serialNumber,
    required this.orderNumber,
    required this.soldAt,
    required this.customerId,
    required this.customerName,
    required this.customerPhone,
  });

  factory PanelModel.fromJson(Map<String, dynamic> json) {
    return PanelModel(
      productId: json['productId'] ?? 0,
      productName: json['productName'] ?? '',
      serialNumber: json['serialNumber']?.toString() ?? '',
      orderNumber: json['orderNumber'] ?? '',

      soldAt: json['soldAt'] != null
          ? DateTime.tryParse(json['soldAt'])
          : null,

      customerId: json['customer']?['id'] ?? '',
      customerName: json['customer']?['name'] ?? '',
      customerPhone: json['customer']?['phone'] ?? '',
    );
  }
}