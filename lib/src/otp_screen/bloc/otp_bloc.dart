import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:space_solar_dealer/src/otp_screen/repo/otp_repositary.dart';
part 'otp_event.dart';
part 'otp_state.dart';


class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OtpRepositary _repository;

  OtpBloc({required OtpRepositary repository})
      : _repository = repository,
        super(OtpState.initial) {
    on<VerifyOtpSubmitted>(_onVerifyOtp);
    on<ResendOtpRequested>(_onResendOtp);
  }

  Future<void> _onVerifyOtp(VerifyOtpSubmitted event, Emitter<OtpState> emit) async {
    emit(state.copyWith(status: OtpStatus.loading));
    try {
      final response = await _repository.verifyOtp(
        mobileNumber: event.phone,
        otp: event.otp,
      );

      if (response.success) {
        // ✅ CORRECTED: Emit .success for login
        emit(state.copyWith(
          status: OtpStatus.success,
          message: "Login Successful",
        ));
      } else {
        emit(state.copyWith(status: OtpStatus.failure, message: response.message));
      }
    } catch (e) {
      final errorMessage = e.toString().replaceAll("Exception:", "");
      emit(state.copyWith(status: OtpStatus.failure, message: errorMessage));
    }
  }

  Future<void> _onResendOtp(
      ResendOtpRequested event,
      Emitter<OtpState> emit,
      ) async {
    try {
      final otp = await _repository.resendOtp(event.phone);

      emit(state.copyWith(
        status: OtpStatus.resendSuccess,
        message: otp,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: OtpStatus.failure,
        message: e.toString(),
      ));
    }
  }
}