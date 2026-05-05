
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_solar_dealer/src/customer_detail/repo/customer_details_repositary.dart';

import 'customer_details_event.dart';
import 'customer_details_state.dart';

class CustomerDetailBloc
    extends Bloc<CustomerDetailEvent, CustomerDetailState> {

  final CustomerDetailsRepositary repository;

  CustomerDetailBloc(this.repository)
      : super(CustomerDetailState()) {

    on<LoadCustomerDetail>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      try {
        final customer = await repository.getCustomerById(event.id);

        emit(state.copyWith(
          isLoading: false,
          customer: customer,
          error: '', // ✅ CLEAR ERROR
        ));
      } catch (e) {
        emit(state.copyWith(
          isLoading: false,
          error: e.toString(),
        ));
      }
    });
  }
}