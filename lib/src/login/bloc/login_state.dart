part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.loginDetails,
    this.message = '',
    this.otp,

  });

  final LoginStatus status;
  final OtpResponse? loginDetails;
  final String message;
  final String? otp;
  static const initial = LoginState();

  LoginState copyWith({
    LoginStatus? status,
    OtpResponse? loginDetails,
    String? message,
    String? otp,
  }) {
    return LoginState(
      status: status ?? this.status,
      loginDetails: loginDetails ?? this.loginDetails,
      message: message ?? this.message,
      otp: otp ?? this.otp,
    );
  }

  @override
  List<Object?> get props => [
    status,
    loginDetails,
    message,
    otp, // ✅ ADD THIS
  ];
}