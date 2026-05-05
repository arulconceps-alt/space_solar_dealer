import 'package:equatable/equatable.dart';

enum OrderStatus { initial, loading, success, failure }

class OrderState extends Equatable {
  final OrderStatus status;
  final String message;
  final String? orderNumber;

  const OrderState({
    this.status = OrderStatus.initial,
    this.message = "",
    this.orderNumber,
  });

  OrderState copyWith({
    OrderStatus? status,
    String? message,
    String? orderNumber,
  }) {
    return OrderState(
      status: status ?? this.status,
      message: message ?? this.message,
      orderNumber: orderNumber ?? this.orderNumber,
    );
  }

  @override
  List<Object?> get props => [status, message, orderNumber];
}