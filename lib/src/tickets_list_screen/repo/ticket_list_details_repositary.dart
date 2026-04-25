import 'package:space_solar_dealer/src/common/models/ticket_model.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';

class TicketListDetailsRepositary {
  final ApiRepository _apiRepository;

  TicketListDetailsRepositary(this._apiRepository);

  Future<List<TicketModel>> fetchTickets({
    required String status,
    int page = 1,
  }) async {
    final response = await _apiRepository.getRequest(
      "/dealer/tickets?status=$status&page=$page&limit=10",
    );

    final List list = response["data"] ?? [];

    return list.map((e) => TicketModel.fromJson(e)).toList();
  }
}