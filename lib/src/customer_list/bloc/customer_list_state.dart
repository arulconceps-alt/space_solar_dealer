import 'package:equatable/equatable.dart';
import 'package:space_solar_dealer/src/common/models/customer_model.dart';

enum CustomerListStatus { initial, loading, success, failure }

class CustomerListState extends Equatable {
  final CustomerListStatus status;
  final List<CustomerModel> customers;
  final List<CustomerModel> filteredCustomers;
  final String message;

  // ✅ ADD THIS
  final int page;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const CustomerListState({
    this.status = CustomerListStatus.initial,
    this.customers = const [],
    this.filteredCustomers = const [],
    this.message = "",
    this.page = 1,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  CustomerListState copyWith({
    CustomerListStatus? status,
    List<CustomerModel>? customers,
    List<CustomerModel>? filteredCustomers,
    String? message,
    int? page,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return CustomerListState(
      status: status ?? this.status,
      customers: customers ?? this.customers,
      filteredCustomers: filteredCustomers ?? this.filteredCustomers,
      message: message ?? this.message,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props =>
      [status, customers, filteredCustomers, message, page, hasReachedMax, isLoadingMore];
}