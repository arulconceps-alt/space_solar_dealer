import 'package:space_solar_dealer/src/common/models/ticket_model.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';

import '../../common/models/panel_model.dart';
class TotalPanelRepositary {
  final ApiRepository _apiRepository;

  TotalPanelRepositary(this._apiRepository);

  Future<List<PanelModel>> getPanelIds({
    String? customerId,
  }) async {
    String url = "/dealer/sold-serials";

    /// CUSTOMER FILTER
    if (customerId != null && customerId.isNotEmpty) {
      url += "?customerId=$customerId";
    }

    final response = await _apiRepository.getRequest(url);

    print("📥 PANEL API RESPONSE: $response");

    if (response["success"] != true) {
      throw Exception(response["message"]);
    }

    final List list = response["data"] ?? [];

    return list
        .map((e) => PanelModel.fromJson(e))
        .toList();
  }
}