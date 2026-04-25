// src/otp_screen/repo/otp_repositary.dart

import 'package:space_solar_dealer/src/common/constants/constansts.dart';
import 'package:space_solar_dealer/src/common/models/login_response.dart';
import 'package:space_solar_dealer/src/common/repos/api_exception.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';
import 'package:space_solar_dealer/src/common/repos/prefences_repository.dart';

class OtpRepositary {
  final ApiRepository _apiRepository;
  final PreferencesRepository _preferencesRepository;

  OtpRepositary(this._apiRepository, this._preferencesRepository);

  Future<LoginResponse> verifyOtp({
    required String mobileNumber,
    required String otp,
  }) async {
    try {
      final responseData = await _apiRepository.postRequest(
        url: "auth/otp/verify",
        data: {
          "phone": "+91$mobileNumber",
          "otp": otp,
        },
        includeRequester: false,
      );

      final loginResponse = LoginResponse.fromJson(responseData);

      if (loginResponse.success && loginResponse.data != null) {
        final accessToken = loginResponse.data!.accessToken;
        final refreshToken = loginResponse.data!.refreshToken;
        final userId = loginResponse.data!.user.id;

        // ✅ SAVE TOKENS
        await _preferencesRepository.setPreference(
          Constants.store.AUTH_TOKEN,
          accessToken,
        );
        final savedToken = _preferencesRepository.getPreference(Constants.store.AUTH_TOKEN);
        print("📦 STORED TOKEN (after save) => $savedToken");
        await _preferencesRepository.setPreference(
          Constants.store.REFRESH_TOKEN,
          refreshToken,
        );

        await _preferencesRepository.setPreference(
          Constants.store.USER_ID,
          userId,
        );

        // ✅ UPDATE DIO HEADER
        _apiRepository.updateToken(accessToken);

        print("✅ ACCESS TOKEN SAVED => $accessToken");

        return loginResponse;
      } else {
        throw ApiException(loginResponse.message);
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException("OTP verification failed.");
    }
  }

  Future<void> resendOtp(String phone) async {
    try {
      await _apiRepository.postRequest(
        url: "auth/otp/send", // Using the correct resend endpoint
        data: {"phone": "+91$phone"},
        includeRequester: false,
      );
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException("Could not resend OTP. Please try again.");
    }
  }
}