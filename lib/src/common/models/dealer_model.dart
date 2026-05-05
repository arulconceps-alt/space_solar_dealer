class DealerModel {
  final String type;
  final String state;
  final String district;

  DealerModel({
    required this.type,
    required this.state,
    required this.district,
  });

  factory DealerModel.fromJson(Map<String, dynamic> json) {
    return DealerModel(
      type: json['type'] ?? '',
      state: json['state'] ?? '',
      district: json['district'] ?? '',
    );
  }
}