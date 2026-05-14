class CustomerModel {
  final String id;
  final String? email;
  final String phone;
  final String name;
  final String? avatarUrl;
  final String roleType;
  final int roleId;
  final String status;

  final String addressLine1;
  final String? addressLine2;

  final int? countryId;
  final int? stateId;
  final int? districtId;
  final int? pincodeId;

  final String? parentId;
  final DateTime createdAt;

  final Profile? customerProfile;
  final List<Order> orders;
  final List<PanelModel> panels;
  final List<SoldSerial> soldSerials;

  CustomerModel({
    required this.id,
    this.email,
    required this.phone,
    required this.name,
    this.avatarUrl,
    required this.roleType,
    required this.roleId,
    required this.status,
    required this.addressLine1,
    this.addressLine2,
    this.countryId,
    this.stateId,
    this.districtId,
    this.pincodeId,
    this.parentId,
    required this.createdAt,
    this.customerProfile,
    required this.orders,
    required this.panels,
    required this.soldSerials,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] ?? '',
      email: json['email'],
      phone: json['phone'] ?? '',
      name: json['name'] ?? '',
      avatarUrl: json['avatarUrl'],
      roleType: json['roleType'] ?? '',
      roleId: json['roleId'] ?? 0,
      status: json['status'] ?? '',

      addressLine1: json['addressLine1'] ?? '',
      addressLine2: json['addressLine2'],

      countryId: json['countryId'],
      stateId: json['stateId'],
      districtId: json['districtId'],
      pincodeId: json['pincodeId'],

      parentId: json['parentId'],
      createdAt: DateTime.parse(json['createdAt']),

      customerProfile: json['customerProfile'] != null
          ? Profile.fromJson(json['customerProfile'])
          : null,

      orders: (json['orders'] as List? ?? [])
          .map((i) => Order.fromJson(i))
          .toList(),

      panels: (json['panels'] as List? ?? [])
          .map((i) => PanelModel.fromJson(i))
          .toList(),
          soldSerials: (json['soldSerials'] as List? ?? [])
    .map((e) => SoldSerial.fromJson(e))
    .toList(),
    );
  }
  CustomerModel copyWith({
  String? id,
  String? email,
  String? phone,
  String? name,
  String? avatarUrl,
  String? roleType,
  int? roleId,
  String? status,
  String? addressLine1,
  String? addressLine2,
  int? countryId,
  int? stateId,
  int? districtId,
  int? pincodeId,
  String? parentId,
  DateTime? createdAt,
  Profile? customerProfile,
  List<Order>? orders,
  List<PanelModel>? panels,
  List<SoldSerial>? soldSerials, 
}) {
  return CustomerModel(
    id: id ?? this.id,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    name: name ?? this.name,
    avatarUrl: avatarUrl ?? this.avatarUrl,
    roleType: roleType ?? this.roleType,
    roleId: roleId ?? this.roleId,
    status: status ?? this.status,
    addressLine1: addressLine1 ?? this.addressLine1,
    addressLine2: addressLine2 ?? this.addressLine2,
    countryId: countryId ?? this.countryId,
    stateId: stateId ?? this.stateId,
    districtId: districtId ?? this.districtId,
    pincodeId: pincodeId ?? this.pincodeId,
    parentId: parentId ?? this.parentId,
    createdAt: createdAt ?? this.createdAt,
    customerProfile: customerProfile ?? this.customerProfile,
    orders: orders ?? this.orders,
    panels: panels ?? this.panels,
     soldSerials: soldSerials ?? this.soldSerials,
  );
}
}

// ─── Address ──────────────────────────────────────────────────────────────────
class Address {
  final String line1;
  final String? line2;
  final int? countryId;
  final int? stateId;
  final int? districtId;
  final int? pincodeId;

  Address({
    required this.line1,
    this.line2,
    this.countryId,
    this.stateId,
    this.districtId,
    this.pincodeId,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      line1: json['line1'] ?? '',
      line2: json['line2'],
      countryId: json['countryId'],
      stateId: json['stateId'],
      districtId: json['districtId'],
      pincodeId: json['pincodeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "line1": line1,
      "line2": line2,
      "countryId": countryId,
      "stateId": stateId,
      "districtId": districtId,
      "pincodeId": pincodeId,
    };
  }
}

// ─── Profile ──────────────────────────────────────────────────────────────────
class Profile {
  final int id;
  final String customerCode;
  final String propertyType;
  final String rooftopArea;
  final String electricityBill;

  Profile({
    required this.id,
    required this.customerCode,
    required this.propertyType,
    required this.rooftopArea,
    required this.electricityBill,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] ?? 0,
      customerCode: json['customerCode'] ?? '',
      propertyType: json['propertyType'] ?? '',
      rooftopArea: json['rooftopArea'] ?? '',
      electricityBill: json['electricityBill'] ?? '',
    );
  }
}

// ─── Order ────────────────────────────────────────────────────────────────────
class Order {
  final String id;
  final String orderNumber;
  final String status;
  final String totalAmount;
  final String paymentStatus;
  final String paymentMethod;
  final List<OrderItem> items;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.totalAmount,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.items,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      orderNumber: json['orderNumber'] ?? '',
      status: json['status'] ?? '',
      totalAmount: json['totalAmount'] ?? '0',
      paymentStatus: json['paymentStatus'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      items: (json['items'] as List? ?? [])
          .map((i) => OrderItem.fromJson(i))
          .toList(),
    );
  }
}

// ─── OrderItem ────────────────────────────────────────────────────────────────
class OrderItem {
  final int id;
  final int quantity;
  final String unitPrice;
  final String totalPrice;
  final String? serialNumber;
  final Product? product;

  OrderItem({
    required this.id,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.serialNumber,
    this.product,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] ?? 0,
      quantity: json['quantity'] ?? 0,
      unitPrice: json['unitPrice'] ?? '0',
      totalPrice: json['totalPrice'] ?? '0',
      serialNumber: json['serialNumber'],
      product:
          json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }
}

// ─── Product ──────────────────────────────────────────────────────────────────
class Product {
  final int id;
  final String name;
  final String category;
  final String customerPrice;
  final int warrantyMonths;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.customerPrice,
    required this.warrantyMonths,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      customerPrice: json['customerPrice'] ?? '0',
      warrantyMonths: json['warrantyMonths'] ?? 0,
    );
  }
}

// ─── PanelModel ───────────────────────────────────────────────────────────────
class PanelModel {
  final String? serialNumber;

  PanelModel({this.serialNumber});

  factory PanelModel.fromJson(Map<String, dynamic> json) {
    return PanelModel(
      serialNumber: json['serialNumber'] ?? json['serial_number'],
    );
  }
}

class SoldSerial {
  final String serialNumber;

  SoldSerial({required this.serialNumber});

  factory SoldSerial.fromJson(Map<String, dynamic> json) {
    return SoldSerial(
      serialNumber: json['serialNumber'] ?? '',
    );
  }
}