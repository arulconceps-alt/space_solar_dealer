import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:space_solar_dealer/src/common/models/dealer_model.dart';
import 'package:space_solar_dealer/src/register_new_customer/repo/new_register_repositary.dart';
part 'new_register_event.dart';
part 'new_register_state.dart';

class NewRegisterBloc extends Bloc<NewRegisterEvent, NewRegisterState> {
  final NewRegisterRepositary _repository;
  final _log = Logger();

  List<Map<String, dynamic>> _allCustomers = [];
  List<DealerModel> _allUsers = [];

  NewRegisterBloc({required NewRegisterRepositary repository})
      : _repository = repository,
        super(NewRegisterState.initial()) {

    on<LoadLocationData>(_onLoadLocationData);
    on<SelectState>(_onSelectState);
    on<SelectDistrict>(_onSelectDistrict);
    on<NewRegisterSubmit>(_onNewRegisterSubmit);
    on<SearchCustomer>(_onSearchCustomer);
    on<ResetRegisterState>((event, emit) {
      emit(state.copyWith(
        status: NewRegisterStatus.initial,
        message: "",
      ));
    });
  }

  /// ✅ Load states
  Future<void> _onLoadLocationData(
      LoadLocationData event,
      Emitter<NewRegisterState> emit,
      ) async {
    try {
      emit(state.copyWith(status: NewRegisterStatus.loading));

      final users = await _repository.fetchDealers();
      _allUsers = users;

      final states = users
          .map((e) => e.state)
          .where((e) => e != null && e.isNotEmpty)
          .toSet()
          .toList();

      emit(state.copyWith(
        status: NewRegisterStatus.initial,
        states: states,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NewRegisterStatus.failure,
        message: e.toString(),
      ));
    }
  }

  /// ✅ Search Customer
  Future<void> _onSearchCustomer(
      SearchCustomer event,
      Emitter<NewRegisterState> emit,
      ) async {
    try {
      if (_allCustomers.isEmpty) {
        _allCustomers = await _repository.fetchAllCustomers();
      }

      final results = _allCustomers.where((e) =>
      e["phone"].toString().contains(event.query) ||
          e["name"].toString().toLowerCase().contains(event.query.toLowerCase())
      ).toList();

      emit(state.copyWith(
        searchResults: results,
        status: NewRegisterStatus.initial, // ✅ RESET STATUS
      ));
    } catch (e) {
      _log.e("Search Error: $e");
    }
  }

  /// ✅ State → District
  Future<void> _onSelectState(
      SelectState event,
      Emitter<NewRegisterState> emit,
      ) async {
    final districts = _allUsers
        .where((e) =>
    e.state == event.state &&
        e.district != null &&
        e.district!.isNotEmpty)
        .map((e) => e.district!)
        .toSet()
        .toList();

    emit(state.copyWith(
      selectedState: event.state,
      districts: districts,
      selectedDistrict: null,
    ));
  }

  void _onSelectDistrict(
      SelectDistrict event,
      Emitter<NewRegisterState> emit,
      ) {
    emit(state.copyWith(selectedDistrict: event.district));
  }

  Future<void> _onNewRegisterSubmit(
      NewRegisterSubmit event,
      Emitter<NewRegisterState> emit,
      ) async {
    try {
      emit(state.copyWith(status: NewRegisterStatus.loading));

      await _repository.registerCustomer(
        name: event.name,
        phone: event.phone,
        email: event.email,
        address: event.address,
        city: event.city,
        state: event.state,
        district: event.district,
        area: event.area,
        panels: event.panels,
        parentId: event.parentId,
      );

      emit(state.copyWith(
        status: NewRegisterStatus.success,
        message: "Customer Registered Successfully",
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NewRegisterStatus.failure,
        message: e.toString(),
      ));
    }
  }
}