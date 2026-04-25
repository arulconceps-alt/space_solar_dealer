import 'package:equatable/equatable.dart';

class OtpResponse extends Equatable {
  final bool success;
  final String message;
  final AuthData? data;

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

  const AuthData({
    required this.message,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      message: json['message'] ?? '',
    );
  }

  @override
  List<Object?> get props => [message];
}