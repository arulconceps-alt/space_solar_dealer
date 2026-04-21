// Change this import to point to your LoginResponse model
import 'package:space_solar_dealer/src/common/constants/constansts.dart';
import 'package:space_solar_dealer/src/common/models/login_response.dart';
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
        url: "auth/verify-otp",
        data: {
          "phone": mobileNumber,
          "otp": otp,
        },
      );

      final loginResponse = LoginResponse.fromJson(responseData);

      if (loginResponse.success && loginResponse.data != null) {
        // 1. Fetch tokens from the response
        final accessToken = loginResponse.data!.tokens.accessToken;
        final userId = loginResponse.data!.user.id;

        // 2. Save to SharedPreferences using your Constants
        await _preferencesRepository.setPreference(
          Constants.store.AUTH_TOKEN, // Use your constant here
          accessToken,
        );

        await _preferencesRepository.setPreference(
          Constants.store.USER_ID,    // Use your constant here
          userId,
        );
       _apiRepository.updateToken(accessToken);

        return loginResponse;
      } else {
        throw Exception(loginResponse.message);
      }
    } catch (e) {
      rethrow;
    }
  }
  Future<void> resendOtp(String phone) async {
    await _apiRepository.postRequest(
      url: "auth/otp",
      data: {
        "phone": phone,
      },
    );
  }
}