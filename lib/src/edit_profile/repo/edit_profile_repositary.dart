import 'package:space_solar_dealer/src/common/models/profile_model.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';

class ProfileRepository {
  final ApiRepository api;

  ProfileRepository(this.api);
  ///Update
  // Future<ProfileModel?> updateProfile(Map<String, dynamic> body) async {
  //   final response = await api.patchRequest(
  //     url: 'dealer/profile',
  //     data: body,
  //   );

  //   if (response['success'] == true) {
  //     return ProfileModel.fromJson(response['data']);
  //   } else {
  //     throw Exception(response['message'] ?? "Update failed");
  //   }
//   // }
//  Future<ProfileModel> updateProfile(Map<String, dynamic> body) async {
//   print("📤 UPDATE PROFILE REQUEST:");
//   print(body);

//   final response = await api.patchRequest(
//     url: 'dealer/profile',
//     data: body,
//   );

//   print("📥 UPDATE PROFILE RESPONSE:");
//   print(response);

//   if (response['success'] == true) {
//     return ProfileModel.fromJson(response['data']);
//   } else {
//     throw Exception(response['message'] ?? "Update failed");
//   }
// }
}