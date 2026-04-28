import 'package:space_solar_dealer/src/common/models/profile_model.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';

class ProfileRepository {
  final ApiRepository api;

  ProfileRepository(this.api);

  /// ✅ GET PROFILE
  Future<ProfileModel> getProfile() async {
    final response = await api.getRequest('auth/profile');

    return ProfileModel.fromJson(response['data']);
    // 👈 IMPORTANT: your API has { success, data }
  }

  Future<void> updateProfile(Map<String, dynamic> body) async {
    await api.patchRequest(
      url: 'dealer/profile',
      data: body,
    );
  }
}