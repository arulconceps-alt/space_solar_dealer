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

    //  ADD THIS INSIDE CONSTRUCTOR
    on<UpdateCustomerInList>(_onUpdateCustomer);
  }

  Future<void> _onLoadCustomers(
    LoadCustomers event,
    Emitter<CustomerListState> emit,
  ) async {
    try {
      final isFirstPage = event.page == 1;

      if (isFirstPage) {
        emit(
          state.copyWith(
            status: CustomerListStatus.loading,
            page: 1,
            hasReachedMax: false,
          ),
        );
      } else {
        emit(state.copyWith(isLoadingMore: true));
      }

      await Future.delayed(const Duration(seconds: 2));

      final data = await repository.fetchAllCustomers(page: event.page);

      final customers = data.map((e) => CustomerModel.fromJson(e)).toList();

      final hasReachedMax = customers.length < 10;

      final updatedList = isFirstPage
          ? customers
          : [...state.customers, ...customers];

      emit(
        state.copyWith(
          status: CustomerListStatus.success,
          customers: updatedList,
          filteredCustomers: updatedList,
          page: event.page,
          hasReachedMax: hasReachedMax,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CustomerListStatus.failure,
          message: e.toString(),
          isLoadingMore: false,
        ),
      );
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

    emit(
      state.copyWith(customers: updatedList, filteredCustomers: updatedList),
    );
  }
}
