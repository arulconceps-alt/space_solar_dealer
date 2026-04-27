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
  final String accessToken;
  final String refreshToken;

  const LoginData({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    final accessToken = json['accessToken'];
    final refreshToken = json['refreshToken'];

    // 🔥 Important safety check
    if (accessToken == null || accessToken.toString().isEmpty) {
      throw Exception("AccessToken missing in response");
    }

    if (refreshToken == null || refreshToken.toString().isEmpty) {
      throw Exception("RefreshToken missing in response");
    }

    return LoginData(
      user: UserModel.fromJson(json['user'] ?? {}),
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  @override
  List<Object?> get props => [user, accessToken, refreshToken];
}

class UserModel extends Equatable {
  final String id;
  final String email;
  final String phone;
  final String name;
  final String roleType;

  const UserModel({
    required this.id,
    required this.email,
    required this.phone,
    required this.name,
    required this.roleType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      name: json['name'] ?? '',
      roleType: json['roleType'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, email, phone, name, roleType];
}