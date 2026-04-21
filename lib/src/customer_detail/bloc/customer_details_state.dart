/*
part of 'customer_bloc.dart';



enum CustomerStatus { initial, loading, success, failure }

class CustomerDetailsState extends Equatable {
  const CustomerDetailsState({
    this.status = CustomerStatus.initial,
    this.message = '',
  });

  final CustomerStatus status;
  final String message;

  static const initial = CustomerDetailsState();

  CustomerDetailsState copyWith({
    CustomerStatus? status,
    String? message,
  }) {
    return CustomerDetailsState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}*/
