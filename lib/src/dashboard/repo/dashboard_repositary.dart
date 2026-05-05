import 'package:space_solar_dealer/src/common/models/dashboard_model.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';

class DashboardRepository {
  final ApiRepository api;

  DashboardRepository(this.api);

  Future<DashboardModel> getDashboard() async {
    final response = await api.getRequest('dealer/dashboard');

    return DashboardModel.fromJson(response['data']);
  }
}