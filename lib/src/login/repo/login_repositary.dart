
import 'package:space_solar_dealer/src/common/constants/constansts.dart';
import 'package:space_solar_dealer/src/common/models/otp_response.dart';
import 'package:space_solar_dealer/src/common/repos/api_exception.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';
import 'package:space_solar_dealer/src/common/repos/prefences_repository.dart';

class LoginRepository {
  final ApiRepository _apiRepository;
  final PreferencesRepository _preferencesRepository;

  LoginRepository(this._apiRepository, this._preferencesRepository);

  /// Sends OTP to the provided mobile number
  Future<OtpResponse> loginWithMobile({required String mobileNumber}) async {
    try {
      final responseData = await _apiRepository.postRequest(
        url: "auth/otp/send",
        data: {"phone": "+91$mobileNumber"},
        includeRequester: false,
      );

      print("FULL OTP RESPONSE => $responseData");

      final otpResponse = OtpResponse.fromJson(responseData);

      if (otpResponse.success) {
        final otp = otpResponse.data?.otp;

        print("EXTRACTED OTP => $otp");

        return otpResponse;
      } else {
        throw ApiException(otpResponse.message);
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException("An unexpected error occurred during login.");
    }
  }

  Future<void> logout() async {
    try {
      await _apiRepository.postRequest(
        url: "auth/logout",
        data: {},
        includeRequester: false,
      );
    } catch (e) {
      rethrow;
    } finally {
      await _preferencesRepository.removePreference(Constants.store.AUTH_TOKEN);
      await _preferencesRepository.removePreference(Constants.store.USER_ID);
      await _preferencesRepository.removePreference(Constants.store.REFRESH_TOKEN);
      _apiRepository.updateToken(null);
    }
  }
}