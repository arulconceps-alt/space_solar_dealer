
import 'package:space_solar_dealer/src/common/constants/constansts.dart';
import 'package:space_solar_dealer/src/common/models/login_response.dart';
import 'package:space_solar_dealer/src/common/models/otp_response.dart';
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
         final deviceToken = _preferencesRepository.getPreference(
      Constants.store.DEVICE_TOKEN,
    );

      final responseData = await _apiRepository.postRequest(
        url: "auth/otp/verify",
        data: {
          "phone": "+91$mobileNumber",
          "otp": otp,
          "deviceToken": deviceToken,
        },
        includeRequester: false,
      );
 print("🚀 VERIFY OTP REQUEST => $responseData");

      final loginResponse = LoginResponse.fromJson(responseData);

      if (loginResponse.success && loginResponse.data != null) {
        final accessToken = loginResponse.data!.accessToken;
        final refreshToken = loginResponse.data!.refreshToken;
        final userId = loginResponse.data!.user.id;

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

  Future<String?> resendOtp(String phone) async {
    try {
      final response = await _apiRepository.postRequest(
        url: "auth/otp/send",
        data: {"phone": "+91$phone"},
        includeRequester: false,
      );

      final message = response['data']?['message'] ?? '';

      final regex = RegExp(r'\d{6}');
      final match = regex.firstMatch(message);

      return match?.group(0);

    } catch (e) {
      rethrow;
    }
  }
}