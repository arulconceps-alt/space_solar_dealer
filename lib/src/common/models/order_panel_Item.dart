class OrderPanelItem {
  final int productId;
  final int quantity;
  final String serialNumber;

  OrderPanelItem({
    required this.productId,
    required this.quantity,
    required this.serialNumber,
  });

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "quantity": quantity,
    "serialNumber": serialNumber,
  };
}