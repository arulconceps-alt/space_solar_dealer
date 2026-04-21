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
  }

  /// 🔥 Load API
  Future<void> _onLoadCustomers(
      LoadCustomers event,
      Emitter<CustomerListState> emit,
      ) async {
    try {
      print("🔥 LoadCustomers called");

      emit(state.copyWith(status: CustomerListStatus.loading));

      final data = await repository.fetchAllCustomers();

      print("🔥 DATA LENGTH: ${data.length}");

      final customers = data
          .map((e) => CustomerModel.fromJson(e))
          .toList();

      emit(state.copyWith(
        status: CustomerListStatus.success,
        customers: customers,
        filteredCustomers: customers,
      ));
    } catch (e) {
      print("❌ ERROR: $e");
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

    /// ✅ If empty → show all customers
    if (query.isEmpty) {
      emit(state.copyWith(filteredCustomers: state.customers));
      return;
    }

    final filtered = state.customers.where((c) {
      final name = c.name.toLowerCase();
      final phone = c.phone.toLowerCase();

      return name.contains(query) || phone.contains(query);
    }).toList();

    emit(state.copyWith(filteredCustomers: filtered));
  }
}