/*
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';

class CustomerDetailsRepositary {
  final ApiRepository _apiRepository;

  CustomerDetailsRepositary(this._apiRepository);

  /// Registers a customer with their details and panel IDs
  Future<void> registerCustomer({
    required String name,
    required String phone,
    required String email,
    required String address,
    required List<String> panelIds,
  }) async {
    try {
      final responseData = await _apiRepository.postRequest(
        // The endpoint from your requirement
        url: "admin/customers",
        data: {
          "name": name,
          "phone": phone,
          "email": email,
          "address": address,
          "panel_ids": panelIds, // Assuming the API expects an array
        },
      );

      return responseData;
    } catch (e) {
      rethrow;
    }
  }
}*/
