import 'package:space_solar_dealer/src/common/models/customer_detail_model.dart';
import 'package:space_solar_dealer/src/common/models/order_request.dart';
import 'package:space_solar_dealer/src/common/models/order_response.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';

class OrderRepositary {
  final ApiRepository _apiRepository;

  OrderRepositary(this._apiRepository);

  Future<OrderResponse> createOrder(OrderRequest request) async {
    final response = await _apiRepository.postRequest(
      url: "/dealer/orders",
      data: request.toJson(),
    );

    return OrderResponse.fromJson(response['data']);
  }
}