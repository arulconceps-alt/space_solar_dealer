class OrderItemModel {
  final String? serialNumber;

  OrderItemModel({this.serialNumber});

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      serialNumber: json['serialNumber'],
    );
  }
}