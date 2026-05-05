import 'package:space_solar_dealer/src/common/models/order_panel_Item.dart';

import 'customer_model.dart';

class OrderRequest {
  final String customerId;
  final List<OrderPanelItem> items;
  final String paymentMethod;
  final String deliveryNotes;

  OrderRequest({
    required this.customerId,
    required this.items,
    required this.paymentMethod,
    required this.deliveryNotes,
  });

  Map<String, dynamic> toJson() {
    return {
      "customerId": customerId,
      "order": {
        "items": items.map((e) => e.toJson()).toList(),
        "paymentMethod": paymentMethod,
        "deliveryNotes": deliveryNotes,
      }
    };
  }
}