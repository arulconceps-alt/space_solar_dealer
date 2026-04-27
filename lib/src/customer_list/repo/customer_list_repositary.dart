
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';

class CustomerListRepositary {
  final ApiRepository _apiRepository;

  CustomerListRepositary(this._apiRepository);

  Future<List<Map<String, dynamic>>> fetchAllCustomers({
    int page = 1,
    int limit = 10,
  }) async {
    final response = await _apiRepository.getRequest(
      "dealer/customers?page=$page&limit=$limit",
    );

    print("📥 API RESPONSE: $response");


    if (response == null || response["success"] != true) {
      throw Exception(response["message"] ?? "Failed to fetch customers");
    }

    final List list = response["data"] ?? [];
    print("🔥 LoadCustomers called");
    print("🔥 DATA LENGTH: ${list.length}");
    return list.cast<Map<String, dynamic>>();
  }
}