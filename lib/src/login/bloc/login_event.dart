part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class OtpGenerate extends LoginEvent {
  final String mobileNumber; // Changed from email/password

  const OtpGenerate({
    required this.mobileNumber,
  });

  @override
  List<Object?> get props => [mobileNumber];
}