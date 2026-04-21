import 'package:equatable/equatable.dart';

class OtpResponse extends Equatable {
  final bool success;
  final String message;
  final AuthData? data; // Changed from LoginData to AuthData for clarity

  const OtpResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? AuthData.fromJson(json['data']) : null,
    );
  }

  @override
  List<Object?> get props => [success, message, data];
}

class AuthData extends Equatable {
  final String message;
  final String otp;

  const AuthData({
    required this.message,
    required this.otp,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      message: json['message'] ?? '',
      otp: json['otp'] ?? '',
    );
  }

  @override
  List<Object?> get props => [message, otp];
}