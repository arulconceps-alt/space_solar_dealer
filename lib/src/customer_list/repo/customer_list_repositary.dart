
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';

class CustomerListRepositary {
  final ApiRepository _apiRepository;

  CustomerListRepositary(this._apiRepository);

  Future<List<Map<String, dynamic>>> fetchAllCustomers() async {
    final response = await _apiRepository.getRequest("admin/customers");

    print("API RESPONSE: $response");

    if (response == null || response["success"] != true) {
      throw Exception("Failed to fetch customers");
    }

    // ✅ CORRECT (data is LIST)
    final List list = response["data"] ?? [];

    return list.cast<Map<String, dynamic>>();
  }
}