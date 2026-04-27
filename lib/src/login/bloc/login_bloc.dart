import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:logger/logger.dart';
import 'package:space_solar_dealer/src/common/error/api_error.dart';
import 'package:space_solar_dealer/src/common/models/otp_response.dart';
import 'package:space_solar_dealer/src/common/repos/api_exception.dart';

import 'package:space_solar_dealer/src/login/repo/login_repositary.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required LoginRepository repository})
      : _repository = repository,
        super(LoginState.initial) {
    on<OtpGenerate>(_onSubmitLogin);
  }

  final LoginRepository _repository;
  final _log = Logger();

  Future<void> _onSubmitLogin(
      OtpGenerate event,
      Emitter<LoginState> emit,
      ) async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));

      final startTime = DateTime.now();

      // Updated to use loginWithMobile and event.mobileNumber
      final result = await _repository.loginWithMobile(
        mobileNumber: event.mobileNumber,
      );

      final elapsed = DateTime.now().difference(startTime);
      if (elapsed < const Duration(seconds: 1)) {
        await Future.delayed(const Duration(seconds: 1) - elapsed);
      }

      emit(
        state.copyWith(
          status: LoginStatus.success,
          loginDetails: result,
          message: "OTP Sent successfully",
        ),
      );
    } catch (e) {
      _log.e('LoginBloc::_onSubmitLogin::Error: $e');

      if (e is ApiException) { // 👈 Use ApiException
        emit(state.copyWith(
          status: LoginStatus.failure,
          message: e.message,
        ));
      } else {
        emit(state.copyWith(
          status: LoginStatus.failure,
          message: "An unexpected error occurred",
        ));
      }
    }
  }
}

