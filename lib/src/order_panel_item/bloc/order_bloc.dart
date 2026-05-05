
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_solar_dealer/src/order_panel_item/bloc/create_order_event.dart';
import 'package:space_solar_dealer/src/order_panel_item/bloc/order_state.dart';
import 'package:space_solar_dealer/src/order_panel_item/repo/order_repositary.dart';

class OrderBloc extends Bloc<CreateOrderEvent, OrderState> {
  final OrderRepositary repository;

  OrderBloc(this.repository) : super(const OrderState()) {
    on<CreateOrderEvent>(_onCreateOrder);
  }

  Future<void> _onCreateOrder(
      CreateOrderEvent event,
      Emitter<OrderState> emit,
      ) async {
    try {
      emit(state.copyWith(status: OrderStatus.loading));

      final response = await repository.createOrder(event.request);

      emit(state.copyWith(
        status: OrderStatus.success,
        orderNumber: response.orderNumber,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: OrderStatus.failure,
        message: e.toString(),
      ));
    }
  }
}