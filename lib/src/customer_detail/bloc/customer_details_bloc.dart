/*
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
part 'customer_event.dart';
part 'customer_state.dart';
import 'package:space_solar_dealer/src/customer_detail/repo/customer_details_repositary.dart';


class CustomerDetailsBloc extends Bloc<CustomerDetailsEvent, CustomerDetailsState> {
  CustomerDetailsBloc({required CustomerDetailsRepositary repository})
      : _repository = repository,
        super(CustomerDetailsState.initial) {
    on<RegisterCustomerSubmit>(_onRegisterSubmit);
  }

  final CustomerDetailsRepositary _repository;
  final _log = Logger();

  Future<void> _onRegisterSubmit(
      RegisterCustomerSubmit event,
      Emitter<CustomerState> emit,
      ) async {
    try {
      emit(state.copyWith(status: CustomerStatus.loading));

      await _repository.registerCustomer(
        name: event.name,
        phone: event.phone,
        email: event.email,
        address: event.address,
        panelIds: event.panelIds,
      );

      emit(state.copyWith(
        status: CustomerStatus.success,
        message: "Customer Registered successfully",
      ));
    } catch (e) {
      _log.e('CustomerBloc::_onRegisterSubmit::Error: $e');
      emit(state.copyWith(
        status: CustomerStatus.failure,
        message: e.toString().replaceAll("Exception: ", ""),
      ));
    }
  }
}*/
