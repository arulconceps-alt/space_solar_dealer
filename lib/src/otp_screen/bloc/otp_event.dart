part of 'otp_bloc.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object?> get props => [];
}

class VerifyOtpSubmitted extends OtpEvent {
  final String phone;
  final String otp;

  const VerifyOtpSubmitted({required this.phone, required this.otp});

  @override
  List<Object?> get props => [phone, otp];
}
class ResendOtpRequested extends OtpEvent {
  final String phone;

  const ResendOtpRequested({required this.phone});

  @override
  List<Object?> get props => [phone];
}