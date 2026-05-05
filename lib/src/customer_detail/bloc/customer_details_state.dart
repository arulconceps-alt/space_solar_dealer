
import 'package:space_solar_dealer/src/common/models/customer_detail_model.dart';

class CustomerDetailState {
  final bool isLoading;
  final CustomerDetailModel? customer;
  final String error;

  CustomerDetailState({
    this.isLoading = false,
    this.customer,
    this.error = '',
  });

  CustomerDetailState copyWith({
    bool? isLoading,
    CustomerDetailModel? customer,
    String? error,
  }) {
    return CustomerDetailState(
      isLoading: isLoading ?? this.isLoading,
      customer: customer ?? this.customer,
      error: error ?? this.error,
    );
  }
}