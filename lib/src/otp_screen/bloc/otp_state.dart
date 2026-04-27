part of 'otp_bloc.dart';

enum OtpStatus {
  initial,
  loading,
  success,
  failure,
  resendSuccess,
}

class OtpState extends Equatable {
  final OtpStatus status;
  final String? message;

  const OtpState({
    this.status = OtpStatus.initial,
    this.message,
  });

  static const initial = OtpState();

  OtpState copyWith({
    OtpStatus? status,
    String? message,
  }) {
    return OtpState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}