import 'package:space_solar_dealer/src/common/constants/constansts.dart';
import 'package:space_solar_dealer/src/common/models/otp_response.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';
import 'package:space_solar_dealer/src/common/repos/prefences_repository.dart';

class LoginRepository {
  final ApiRepository _apiRepository;
  final PreferencesRepository _preferencesRepository;

  LoginRepository(this._apiRepository, this._preferencesRepository);

  Future<OtpResponse> loginWithMobile({
    required String mobileNumber,
  }) async {
    try {
      final responseData = await _apiRepository.postRequest(
        url: "auth/otp",
        data: {
          "phone": mobileNumber,
        },
      );

      // Create the response object from the raw map
      final otpResponse = OtpResponse.fromJson(responseData);

      if (otpResponse.success) {
        // NOTE: Usually, you don't save tokens here because the user
        // hasn't verified the OTP yet. You would save tokens in the
        // 'verifyOtp' method instead.

        return otpResponse;
      } else {
        throw Exception(otpResponse.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _preferencesRepository.removePreference(Constants.store.AUTH_TOKEN);
      await _preferencesRepository.removePreference(Constants.store.USER_ID);
    } catch (e) {
      rethrow;
    }
  }
}