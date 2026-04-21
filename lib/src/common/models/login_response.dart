import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final bool success;
  final String message;
  final LoginData? data;

  const LoginResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }

  @override
  List<Object?> get props => [success, message, data];
}

class LoginData extends Equatable {
  final UserModel user;
  final TokenModel tokens;

  const LoginData({required this.user, required this.tokens});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: UserModel.fromJson(json['user'] ?? {}),
      tokens: TokenModel.fromJson(json['tokens'] ?? {}),
    );
  }

  @override
  List<Object?> get props => [user, tokens];
}

class UserModel extends Equatable {
  final String id;
  final String email;
  final String phone;
  final String role;
  final String rank;
  final String region;
  final String district;
  final String kycStatus;
  final String fullName;
  final num walletBalance;
  final String status;

  const UserModel({
    required this.id,
    required this.email,
    required this.phone,
    required this.role,
    required this.rank,
    required this.region,
    required this.district,
    required this.kycStatus,
    required this.fullName,
    required this.walletBalance,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      rank: json['rank'] ?? '',
      region: json['region'] ?? '',
      district: json['district'] ?? '',
      kycStatus: json['kycStatus'] ?? '',
      fullName: json['fullName'] ?? '',
      walletBalance: json['walletBalance'] ?? 0,
      status: json['status'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
    id, email, phone, role, rank, region,
    district, kycStatus, fullName, walletBalance, status
  ];
}

class TokenModel extends Equatable {
  final String accessToken;
  final String refreshToken;

  const TokenModel({required this.accessToken, required this.refreshToken});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }

  @override
  List<Object?> get props => [accessToken, refreshToken];
}