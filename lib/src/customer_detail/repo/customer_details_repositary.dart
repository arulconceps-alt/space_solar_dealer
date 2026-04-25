import 'package:space_solar_dealer/src/common/models/customer_detail_model.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';

class CustomerDetailsRepositary {
  final ApiRepository _apiRepository;

  CustomerDetailsRepositary(this._apiRepository);

  Future<CustomerDetailModel> getCustomerById(String id) async {
    final response = await _apiRepository.getRequest("/dealer/customers/$id");

    if (response["success"] != true) {
      throw Exception("Failed to fetch customer detail");
    }

    final data = response["data"];
    print("API RESPONSE: $response");
    if (data == null) {
      throw Exception("No customer data found");
    }

    final List dataList = response["data"] ?? [];

    final customerJson = dataList.firstWhere(
          (e) => e["id"] == id,
    );

    return CustomerDetailModel.fromJson(customerJson);
  }
}