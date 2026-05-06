import 'package:space_solar_dealer/src/common/models/ticket_model.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';

import '../../common/models/panel_model.dart';

class TicketListDetailsRepositary {
  final ApiRepository _apiRepository;

  TicketListDetailsRepositary(this._apiRepository);

  Future<List<TicketModel>> fetchTickets({
    int page = 1,
    int limit = 10,
  }) async {
    final response = await _apiRepository.getRequest(
      "/dealer/tickets?page=$page&limit=10",
    );

      print("📥 FETCH TICKETS RESPONSE: $response");
  
  // Print response status
  print("Response Success: ${response["success"]}");
  print("Response Message: ${response["message"]}");
  
  final List list = response["data"] ?? [];
  
  // Print data details
  print("📊 Tickets count: ${list.length}");
  print("📊 Tickets data: $list");
    return list.map((e) => TicketModel.fromJson(e)).toList();
  }
  /// create Ticket
  // Future<Map<String, dynamic>> createTicket({
  //   required String customerId,
  //   required String title,
  //   required String description,
  //   required String category,
  //   required String priority,
  //   required String scheduledAt,
  //   required List<Map<String, dynamic>> products,
  // }) async {

    
  //   final body = {
  //     "customerId": customerId,
  //     "title": title,
  //     "description": description,
  //     "category": category,
  //     "priority": priority,
  //     "scheduledAt": scheduledAt,
  //     "products": products,
  //   };

  //   final response = await _apiRepository.postRequest(
  //     url: "/dealer/tickets",
  //     data: body,
  //   );

  //   print("✅ CREATE TICKET RESPONSE: $response");

  //   if (response["success"] != true) {
  //     throw Exception(response["message"]);
  //   }

  //   return response["data"];
  // }

Future<Map<String, dynamic>> createTicket({
  required String customerId,
  required String title,
  required String description,
  required String category,
  required String priority,
  required String scheduledAt,
  required List<Map<String, dynamic>> products,
}) async {

  final body = {
    "customerId": customerId,
    "title": title,
    "description": description,
    "category": category,
    "priority": priority,
    "scheduledAt": scheduledAt,
    "products": products,
  };

  // 🔥 PRINT REQUEST HERE
  print("📤 CREATE TICKET REQUEST => $body");

  final response = await _apiRepository.postRequest(
    url: "/dealer/tickets",
    data: body,
  );

  print("📥 CREATE TICKET RESPONSE => $response");

  if (response["success"] != true) {
    throw Exception(response["message"]);
  }

  return response["data"];
}
  /// Panel ID's
  /// 🔥 GET PANEL IDS
  // Future<List<PanelModel>> getPanelIds() async {
  //   final response = await _apiRepository.getRequest("/dealer/sold-serials");

  //   print("📥 PANEL API RESPONSE: $response");

  //   if (response["success"] != true) {
  //     throw Exception(response["message"]);
  //   }

  //   final List list = response["data"] ?? [];

  //   return list.map((e) => PanelModel.fromJson(e)).toList();
  // }
  Future<List<PanelModel>> getPanelIds(String customerId) async {
  final response = await _apiRepository.getRequest(
    "/dealer/sold-serials?customerId=$customerId",
  );

  print("📥 PANEL API RESPONSE: $response");

  if (response["success"] != true) {
    throw Exception(response["message"]);
  }

  final List list = response["data"] ?? [];

  return list.map((e) => PanelModel.fromJson(e)).toList();
}

}