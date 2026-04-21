import 'package:space_solar_dealer/src/common/models/dealer_model.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';

class NewRegisterRepositary {
  final ApiRepository _apiRepository;

  NewRegisterRepositary(this._apiRepository);

  Future<void> registerCustomer({
    required String name,
    required String phone,
    required String email,
    required String address,
    required String city,
    required String state,
    required String district,
    required String area,
    required List<String> panels,// ✅ int list
    required String parentId,
  }) async {
    try {
      final response = await _apiRepository.postRequest(
        url: "admin/customers",
        data: {
          "name": name,
          "phone": phone,
          "email": email,
          "address": address,
          "city": city,
          "state": state,
          "district": district,
          "area": area,
          "panels": panels, // ✅ correct key
          "parentId": parentId,
        },
      );

      if (response == null) {
        throw Exception("Invalid response from server");
      }
    } catch (e) {
      throw Exception("Register failed: $e");
    }
  }

  Future<List<DealerModel>> fetchDealers() async {
    final response = await _apiRepository.getRequest("admin/dealer");

    if (response == null || response["success"] != true) {
      throw Exception("Failed to fetch dealers");
    }

    // Ensure we access the correct nested list from your API structure
    final List list = response["data"]["users"] ?? [];
    return list.map((e) => DealerModel.fromJson(e)).toList();
  }

  Future<List<Map<String, dynamic>>> fetchAllCustomers() async {
    final response = await _apiRepository.getRequest("admin/customers");

    if (response == null || response["success"] != true) {
      throw Exception("Failed to fetch customers");
    }

    final List list = response["data"] ?? [];
    return list.cast<Map<String, dynamic>>();
  }
}