import 'order_item_model.dart';

class OrderModel {
  final String id;
  final String orderNumber;
  final List<OrderItemModel> items; // ✅ ADD THIS

  OrderModel({
    required this.id,
    required this.orderNumber,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      orderNumber: json['orderNumber'] ?? '',

      /// ✅ PARSE ITEMS
      items: (json['items'] as List?)
          ?.map((e) => OrderItemModel.fromJson(e))
          .toList() ??
          [],
    );
  }
}