import 'package:space_solar_dealer/src/common/repos/api_repository.dart';


class NewRegisterRepositary {
  final ApiRepository _apiRepository;
  NewRegisterRepositary(this._apiRepository);

  Future<void> registerCustomer({
    required String name,
    required String phone,
    required int countryId,
    required int stateId,
    required int districtId,
    required int pincodeId,
    required String addressLine,
    required List<String> panels,
    String? parentId,

    // ✅ Make these dynamic (not hardcoded)
    String propertyType = "commercial",
    double rooftopArea = 2500.0,
    double electricityBill = 12000.0,
  }) async {
    final body = {
      "name": name,
      "phone": phone.startsWith("+91") ? phone : "+91$phone", // ✅ ensure format

      if (parentId != null) "parentId": parentId, // ✅ only send if exists

      "address": {
        "line1": addressLine,
        "countryId": countryId,
        "stateId": stateId,
        "districtId": districtId,
        "pincodeId": pincodeId,
      },

      "order": {
        "items": panels.map((e) => {
          "productId": 1, // ⚠️ Replace with real productId later
          "quantity": 1,
          "serialNumber": e,
        }).toList(),

        "paymentMethod": "CASH",
        "deliveryNotes": "Urgent order",
      },

      "propertyType": propertyType,
      "rooftopArea": rooftopArea,
      "electricityBill": electricityBill,
    };

    final response = await _apiRepository.postRequest(
      url: "dealer/customers",
      data: body,
    );

    if (response == null) {
      throw Exception("Server error");
    }
    if (response["success"] != true) {
      throw Exception(response["message"] ?? "Registration failed");
    }
  }


 /* Future<List<Map<String, dynamic>>> fetchAllCustomers() async {
    final response = await _apiRepository.postRequest(
      url: "dealer/customers/search",
      data: {},
    );

    if (response == null || response["success"] != true) {
      throw Exception("Failed to fetch customers");
    }

    final List list = response["data"] ?? [];
    return list.cast<Map<String, dynamic>>();
  }*/

  Future<List<Map<String, dynamic>>> fetchStates(int countryId) async {
    final res = await _apiRepository.getRequest("static/states?countryId=$countryId");

    if (res == null || res["success"] != true) {
      throw Exception(res["message"] ?? "Failed to fetch states");
    }

    return List<Map<String, dynamic>>.from(res["data"] ?? []);
  }

  Future<List<Map<String, dynamic>>> fetchDistricts(int stateId) async {
    final res = await _apiRepository.getRequest("static/districts?stateId=$stateId");
    return List<Map<String, dynamic>>.from(res["data"] ?? []);
  }

  Future<List<Map<String, dynamic>>> fetchPincodes(int districtId) async {
    final res = await _apiRepository.getRequest("static/pincodes?districtId=$districtId");
    return List<Map<String, dynamic>>.from(res["data"] ?? []);
  }
  Future<List<Map<String, dynamic>>> getCustomers() async {
    final response = await _apiRepository.getRequest("/dealer/customers");

    if (response["success"] != true) {
      throw Exception("Failed to fetch customers");
    }

    return List<Map<String, dynamic>>.from(response["data"]);
  }
}