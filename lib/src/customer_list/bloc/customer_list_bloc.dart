import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:space_solar_dealer/src/common/models/customer_model.dart';
import 'package:space_solar_dealer/src/customer_list/bloc/customer_list_state.dart';
import 'package:space_solar_dealer/src/customer_list/repo/customer_list_repositary.dart';

part 'customer_list_event.dart';

class CustomerListBloc extends Bloc<CustomerListEvent, CustomerListState> {
  final CustomerListRepositary repository;

  CustomerListBloc({required this.repository})
      : super(const CustomerListState()) {

    on<LoadCustomers>(_onLoadCustomers);
    on<SearchCustomers>(_onSearchCustomers);

    // ✅ ADD THIS INSIDE CONSTRUCTOR
    on<UpdateCustomerInList>(_onUpdateCustomer);
  }

  Future<void> _onLoadCustomers(
    LoadCustomers event,
    Emitter<CustomerListState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CustomerListStatus.loading));

      final data = await repository.fetchAllCustomers();

      final customers = data
          .map((e) => CustomerModel.fromJson(e))
          .toList();

      emit(state.copyWith(
        status: CustomerListStatus.success,
        customers: customers,
        filteredCustomers: customers,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CustomerListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  void _onSearchCustomers(
    SearchCustomers event,
    Emitter<CustomerListState> emit,
  ) {
    final query = event.query.trim().toLowerCase();

    if (query.isEmpty) {
      emit(state.copyWith(filteredCustomers: state.customers));
      return;
    }

    final filtered = state.customers.where((c) {
      return c.name.toLowerCase().contains(query) ||
          c.phone.toLowerCase().contains(query);
    }).toList();

    emit(state.copyWith(filteredCustomers: filtered));
  }

  void _onUpdateCustomer(
    UpdateCustomerInList event,
    Emitter<CustomerListState> emit,
  ) {
    final updatedList = state.customers.map((c) {
      return c.id == event.customer.id ? event.customer : c;
    }).toList();

    emit(state.copyWith(
      customers: updatedList,
      filteredCustomers: updatedList,
    ));
  }
}