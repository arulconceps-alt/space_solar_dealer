import 'package:equatable/equatable.dart';

class PromoModel extends Equatable {
  final String code;
  final String description;
  final String minDeposit;
  final String validity;

  const PromoModel({
    required this.code,
    required this.description,
    required this.minDeposit,
    required this.validity,
  });

  PromoModel copyWith({
    String? code,
    String? description,
    String? minDeposit,
    String? validity,
  }) {
    return PromoModel(
      code: code ?? this.code,
      description: description ?? this.description,
      minDeposit: minDeposit ?? this.minDeposit,
      validity: validity ?? this.validity,
    );
  }

  factory PromoModel.fromJson(Map<String, dynamic> json) {
    return PromoModel(
      code: json['code'] ?? '',
      description: json['description'] ?? '',
      minDeposit: json['minDeposit'] ?? '',
      validity: json['validity'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "code": code,
    "description": description,
    "minDeposit": minDeposit,
    "validity": validity,
  };

  factory PromoModel.empty() {
    return const PromoModel(
      code: '',
      description: '',
      minDeposit: '',
      validity: '',
    );
  }

  @override
  List<Object?> get props => [code, description, minDeposit, validity];
}
