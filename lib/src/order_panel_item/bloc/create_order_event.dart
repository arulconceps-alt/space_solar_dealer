
import 'package:equatable/equatable.dart';
import 'package:space_solar_dealer/src/common/models/order_request.dart';

class CreateOrderEvent extends Equatable {
  final OrderRequest request;

  const CreateOrderEvent(this.request);

  @override
  List<Object?> get props => [request];
}