import 'package:space_solar_dealer/src/common/repos/api_repository.dart';

class NewRegisterRepositary {
  final ApiRepository _apiRepository;
  NewRegisterRepositary(this._apiRepository);

  // ✅ REGISTER CUSTOMER
  Future<void> registerCustomer({
    required String name,
    required String phone,
    required String email, // ✅ ADD THIS
    required int countryId,
    required int stateId,
    required int districtId,
    required int pincodeId,
    required String addressLine,
    required List<String> panels,
    String? parentId,
    String propertyType = "commercial",
    double rooftopArea = 2500.0,
    double electricityBill = 12000.0,
  }) async {
    final body = {
      "name": name,
      "phone": phone.startsWith("+91") ? phone : "+91$phone",
      "email": email,

      if (parentId != null) "parentId": parentId,

      "address": {
        "line1": addressLine,
        "countryId": countryId,
        "stateId": stateId,
        "districtId": districtId,
        "pincodeId": pincodeId,
      },

      "order": {
        "items": panels.map((e) => {
          "productId": 1,
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

    if (response == null || response["success"] != true) {
      throw Exception(response?["message"] ?? "Registration failed");
    }
  }

  // ✅ STATES
  Future<List<Map<String, dynamic>>> fetchStates(int countryId) async {
    final res =
    await _apiRepository.getRequest("static/states?countryId=$countryId");

    if (res == null || res["success"] != true) {
      throw Exception(res?["message"] ?? "Failed to fetch states");
    }

    return List<Map<String, dynamic>>.from(res["data"] ?? []);
  }

  // ✅ DISTRICTS
  Future<List<Map<String, dynamic>>> fetchDistricts(int stateId) async {
    final res =
    await _apiRepository.getRequest("static/districts?stateId=$stateId");

    if (res == null || res["success"] != true) {
      throw Exception(res?["message"] ?? "Failed to fetch districts");
    }

    return List<Map<String, dynamic>>.from(res["data"] ?? []);
  }

  // ✅ PINCODES
  Future<List<Map<String, dynamic>>> fetchPincodes(int districtId) async {
    final res =
    await _apiRepository.getRequest("static/pincodes?districtId=$districtId");

    if (res == null || res["success"] != true) {
      throw Exception(res?["message"] ?? "Failed to fetch pincodes");
    }

    return List<Map<String, dynamic>>.from(res["data"] ?? []);
  }

  // ✅ CUSTOMERS
  Future<List<Map<String, dynamic>>> getCustomers() async {
    try {
      final response = await _apiRepository.getRequest("dealer/customers");

      if (response == null) {
        throw Exception("No response from server");
      }

      if (response["success"] != true) {
        throw Exception(response["message"] ?? "Failed to fetch customers");
      }

      final data = response["data"];

      if (data == null || data is! List) {
        return [];
      }

      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      throw Exception("API Error: $e");
    }
  }
  Future<void> addOrderToExistingCustomer({
    required String customerId,
    required List<String> panels,
  }) async {
    final body = {
      "customerId": customerId,
      "order": {
        "items": panels.map((serial) => {
          "productId": 1,
          "quantity": 1,
          "serialNumber": serial,
        }).toList(),
        "paymentMethod": "CASH",
        "deliveryNotes": "Extra panels added",
      }
    };

    final response = await _apiRepository.postRequest(
      url: "dealer/orders",
      data: body,
    );

    if (response == null || response["success"] != true) {
      throw Exception(response?["message"] ?? "Failed to add panels to existing customer");
    }
  }
}