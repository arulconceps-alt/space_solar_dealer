import 'package:space_solar_dealer/src/common/models/ticket_model.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';

import '../../common/models/panel_model.dart';

class TotalPanelRepositary {
  final ApiRepository _apiRepository;

  TotalPanelRepositary(this._apiRepository);


  /// Panel ID's
  /// 🔥 GET PANEL IDS
  Future<List<PanelModel>> getPanelIds() async {
    final response = await _apiRepository.getRequest("/dealer/sold-serials");

    print("📥 PANEL API RESPONSE: $response");

    if (response["success"] != true) {
      throw Exception(response["message"]);
    }

    final List list = response["data"] ?? [];

    return list.map((e) => PanelModel.fromJson(e)).toList();
  }

}