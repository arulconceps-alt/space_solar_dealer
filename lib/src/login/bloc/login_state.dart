part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.loginDetails,
    this.message = '',
  });

  final LoginStatus status;
  final OtpResponse? loginDetails;
  final String message;

  static const initial = LoginState();

  LoginState copyWith({
    LoginStatus? status,
    OtpResponse? loginDetails,
    String? message,
  }) {
    return LoginState(
      status: status ?? this.status,
      loginDetails: loginDetails ?? this.loginDetails,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    status,
    loginDetails,
    message,
  ];
}