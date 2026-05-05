import 'package:equatable/equatable.dart';
import 'package:space_solar_dealer/src/common/models/customer_model.dart';

enum CustomerListStatus { initial, loading, success, failure }

class CustomerListState extends Equatable {
  final CustomerListStatus status;
  final List<CustomerModel> customers;
  final List<CustomerModel> filteredCustomers;
  final String message;

  const CustomerListState({
    this.status = CustomerListStatus.initial,
    this.customers = const [],
    this.filteredCustomers = const [],
    this.message = "",
  });

  CustomerListState copyWith({
    CustomerListStatus? status,
    List<CustomerModel>? customers,
    List<CustomerModel>? filteredCustomers,
    String? message,
  }) {
    return CustomerListState(
      status: status ?? this.status,
      customers: customers ?? this.customers,
      filteredCustomers: filteredCustomers ?? this.filteredCustomers,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, customers, filteredCustomers, message];
}