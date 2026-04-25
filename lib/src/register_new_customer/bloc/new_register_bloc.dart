import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_solar_dealer/src/register_new_customer/repo/new_register_repositary.dart';
part 'new_register_event.dart';
part 'new_register_state.dart';

class NewRegisterBloc extends Bloc<NewRegisterEvent, NewRegisterState> {
  final NewRegisterRepositary _repository;
  List<Map<String, dynamic>> _allCustomers = [];
  List<Map<String, dynamic>> searchResults = [];

  NewRegisterBloc({required NewRegisterRepositary repository})
      : _repository = repository,
        super(NewRegisterState.initial()) {
    on<LoadLocationData>(_onLoadLocationData);
    on<SelectState>(_onSelectState);
    on<SelectDistrict>(_onSelectDistrict);
    on<SelectPincode>(_onSelectPincode);
    on<SearchCustomer>(_onSearchCustomer);
    on<NewRegisterSubmit>(_onSubmit);
    on<ResetRegisterState>((event, emit) => emit(NewRegisterState.initial()));
    on<LoadCustomers>((event, emit) async {
      final customers = await _repository.getCustomers();
    });
  }

  Future<void> _onLoadLocationData(
      LoadLocationData event, Emitter<NewRegisterState> emit) async {
    emit(state.copyWith(status: NewRegisterStatus.loading));
    try {
      final states = await _repository.fetchStates(1);
      emit(state.copyWith(status: NewRegisterStatus.initial, states: states));
    } catch (e) {
      emit(state.copyWith(status: NewRegisterStatus.failure, message: e.toString()));
    }
  }

  Future<void> _onSelectState(
      SelectState event, Emitter<NewRegisterState> emit) async {
    emit(state.copyWith(
      selectedState: event.name,
      selectedStateId: event.id,
      selectedDistrict: null,
      selectedDistrictId: null,
      districts: [],
    ));

    try {
      final districts = await _repository.fetchDistricts(event.id);
      emit(state.copyWith(districts: districts));
    } catch (e) {
      emit(state.copyWith(status: NewRegisterStatus.failure, message: e.toString()));
    }
  }

  Future<void> _onSelectDistrict(
      SelectDistrict event, Emitter<NewRegisterState> emit) async {
    emit(state.copyWith(
      selectedDistrict: event.name,
      selectedDistrictId: event.id,
      pincodesList: [],
      selectedPincode: null,     // ✅ CLEAR
      selectedPincodeId: null,   // ✅ CLEAR
      status: NewRegisterStatus.loading,
    ));

    try {
      final pincodes = await _repository.fetchPincodes(event.id);
      emit(state.copyWith(
        pincodesList: pincodes,
        status: NewRegisterStatus.initial,
      ));
    } catch (e) {
      emit(state.copyWith(status: NewRegisterStatus.failure, message: e.toString()));
    }
  }

  void _onSelectPincode(
      SelectPincode event,
      Emitter<NewRegisterState> emit,
      ) {
    emit(state.copyWith(
      selectedPincodeId: event.id,
      selectedPincode: event.code, // ✅ IMPORTANT
    ));
  }

  Future<void> _onSearchCustomer(
      SearchCustomer event, Emitter<NewRegisterState> emit) async {
    try {
      if (_allCustomers.isEmpty) {
        _allCustomers = await _repository.getCustomers();
      }

      final query = event.query.toLowerCase();
      final results = _allCustomers.where((e) {
        return e["phone"].toString().contains(query) ||
            e["name"].toString().toLowerCase().contains(query);
      }).toList();

      emit(state.copyWith(searchResults: results));
    } catch (e) {
      emit(state.copyWith(
          status: NewRegisterStatus.failure,
          message: "Customer search failed"));
    }
  }

  Future<void> _onSubmit(
      NewRegisterSubmit event, Emitter<NewRegisterState> emit) async {
    emit(state.copyWith(status: NewRegisterStatus.loading));
    try {
      await _repository.registerCustomer(
        name: event.name,
        phone: event.phone,
        countryId: 1,
        stateId: event.stateId,
        districtId: event.districtId,
        pincodeId: event.pincodeId,
        addressLine: event.addressLine,
        panels: event.panels,
        propertyType: event.propertyType,
        rooftopArea: event.rooftopArea,
        electricityBill: event.electricityBill,
      );

      emit(state.copyWith(status: NewRegisterStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: NewRegisterStatus.failure, message: e.toString()));
    }
  }
}