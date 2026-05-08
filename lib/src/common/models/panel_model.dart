class PanelModel {
  final int productId;
  final String productName;
  final String serialNumber;
  final String orderNumber;
  final DateTime? soldAt;
  final DateTime? performanceWarrantyEndDate;
  final DateTime? physicalWarrantyEndDate;
  final DateTime? warrantyStartDate;
  final String customerId;
  final String customerName;
  final String customerPhone;
  final String customerEmail;  // Add this
  final String customerAddress; // Add this

  PanelModel({
    required this.productId,
    required this.productName,
    required this.serialNumber,
    required this.orderNumber,
    required this.soldAt,
    required this.performanceWarrantyEndDate,
    required this.physicalWarrantyEndDate,
    required this.warrantyStartDate,
    required this.customerId,
    required this.customerName,
    required this.customerPhone,
    required this.customerEmail,  // Add this
    required this.customerAddress, // Add this
  });

  factory PanelModel.fromJson(Map<String, dynamic> json) {
    return PanelModel(
      productId: json['productId'] ?? 0,
      productName: json['productName'] ?? '',
      serialNumber: json['serialNumber']?.toString() ?? '',
      orderNumber: json['orderNumber'] ?? '',
      soldAt: json['soldAt'] != null ? DateTime.tryParse(json['soldAt']) : null,
      performanceWarrantyEndDate: json['performanceWarrantyEndDate'] != null 
          ? DateTime.tryParse(json['performanceWarrantyEndDate']) 
          : null,
      physicalWarrantyEndDate: json['physicalWarrantyEndDate'] != null 
          ? DateTime.tryParse(json['physicalWarrantyEndDate']) 
          : null,
      warrantyStartDate: json['warrantyStartDate'] != null 
          ? DateTime.tryParse(json['warrantyStartDate']) 
          : null,
      customerId: json['customer']?['id'] ?? '',
      customerName: json['customer']?['name'] ?? '',
      customerPhone: json['customer']?['phone']?.toString().replaceAll("+91", "") ?? '',
      customerEmail: json['customer']?['email'] ?? '',  // Add this
      customerAddress: json['customer']?['addressLine1'] ?? '', // Add this
    );
  }
}


class TotalPanelListPanelModel {
  final int productId;
  final String productName;
  final String serialNumber;
  final String orderNumber;
  final DateTime? soldAt;
  final DateTime? performanceWarrantyEndDate;
  final DateTime? physicalWarrantyEndDate;
  final DateTime? warrantyStartDate;
  final String customerId;
  final String customerName;
  final String customerPhone;
  final String customerEmail;
  final String customerAddress;

  TotalPanelListPanelModel({
    required this.productId,
    required this.productName,
    required this.serialNumber,
    required this.orderNumber,
    required this.soldAt,
    required this.performanceWarrantyEndDate,
    required this.physicalWarrantyEndDate,
    required this.warrantyStartDate,
    required this.customerId,
    required this.customerName,
    required this.customerPhone,
    required this.customerEmail,
    required this.customerAddress,
  });

  factory TotalPanelListPanelModel.fromJson(Map<String, dynamic> json) {
    return TotalPanelListPanelModel(
      productId: json['productId'] ?? 0,
      productName: json['productName'] ?? '',
      serialNumber: json['serialNumber']?.toString() ?? '',
      orderNumber: json['orderNumber'] ?? '',
      soldAt: json['soldAt'] != null ? DateTime.tryParse(json['soldAt']) : null,
      performanceWarrantyEndDate: json['performanceWarrantyEndDate'] != null 
          ? DateTime.tryParse(json['performanceWarrantyEndDate']) 
          : null,
      physicalWarrantyEndDate: json['physicalWarrantyEndDate'] != null 
          ? DateTime.tryParse(json['physicalWarrantyEndDate']) 
          : null,
      warrantyStartDate: json['warrantyStartDate'] != null 
          ? DateTime.tryParse(json['warrantyStartDate']) 
          : null,
      customerId: json['customer']?['id'] ?? '',
      customerName: json['customer']?['name'] ?? '',
      customerPhone: json['customer']?['phone']?.toString().replaceAll("+91", "") ?? '',
      customerEmail: json['customer']?['email'] ?? '',
      customerAddress: json['customer']?['addressLine1'] ?? '',
    );
  }
}