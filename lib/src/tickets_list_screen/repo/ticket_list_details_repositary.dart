import 'dart:io';

import 'package:dio/dio.dart';
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

  
Future<Map<String, dynamic>> createTicket({
  required String customerId,
  required String title,
  required String description,
  required String category,
  required String priority,
  required String scheduledAt,
  required List<Map<String, dynamic>> products,
  List<File>? images, // Add this parameter
}) async {

  // Build FormData instead of a plain Map
  final formData = FormData.fromMap({
    "customerId": customerId,
    "title": title,
    "description": description,
    "category": category,
    "priority": priority,
    "scheduledAt": scheduledAt,

    // Flatten products list into bracket-notation fields
    for (int i = 0; i < products.length; i++) ...{
      "products[$i][productId]": products[i]["productId"],
      "products[$i][serialNo]":  products[i]["serialNo"],
    },

    // Attach image files if provided
    if (images != null)
      "images": [
        for (final file in images)
          await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          ),
      ],
  });

  print("📤 CREATE TICKET FORM DATA => ${formData.fields}");

  final response = await _apiRepository.postMultipartRequest(
    url: "/dealer/tickets",
    data: formData,
  );

  print("📥 CREATE TICKET RESPONSE => $response");

  if (response["success"] != true) {
    throw Exception(response["message"]);
  }

  return response["data"];
}

Future<TicketModel> getTicketDetails(String ticketId) async {
  try {
    final response = await _apiRepository.getRequest(
      "/dealer/tickets/$ticketId",
    );

    print("✅ TICKET DETAILS API: $response");

    final data = response["data"];

    return TicketModel.fromJson(data);
  } catch (e) {
    print("❌ GET TICKET DETAILS ERROR: $e");
    rethrow;
  }
}

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