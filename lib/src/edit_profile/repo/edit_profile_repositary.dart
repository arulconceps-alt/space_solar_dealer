import 'package:space_solar_dealer/src/common/models/profile_model.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';

class ProfileRepository {
  final ApiRepository api;

  ProfileRepository(this.api);
  ///Update
  Future<void> updateProfile(Map<String, dynamic> body) async {
    await api.patchRequest(
      url: 'dealer/profile',
      data: body,
    );
  }
}