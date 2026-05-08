import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_solar_dealer/src/register_new_customer/repo/new_register_repositary.dart';

part 'new_register_event.dart';
part 'new_register_state.dart';

class NewRegisterBloc extends Bloc<NewRegisterEvent, NewRegisterState> {
  final NewRegisterRepositary _repository;

  List<Map<String, dynamic>> _allCustomers = [];

  NewRegisterBloc({required NewRegisterRepositary repository})
      : _repository = repository,
        super(NewRegisterState.initial()) {

    on<LoadLocationData>(_onLoadLocationData);
    on<SelectState>(_onSelectState);
    on<SelectDistrict>(_onSelectDistrict);
    on<SelectPincode>(_onSelectPincode);
    on<SearchCustomer>(_onSearchCustomer);
    on<LoadCustomers>(_onLoadCustomers);
    on<NewRegisterSubmit>(_onSubmit);
    on<SelectExistingCustomer>(_onSelectExistingCustomer);
    on<ResetRegisterState>(_onReset);

  }

  Future<void> _onSelectExistingCustomer(
      SelectExistingCustomer event,
      Emitter<NewRegisterState> emit,
      ) async {

    print("🟡 SELECT EXISTING CUSTOMER EVENT");

    emit(state.copyWith(
      selectedCustomerId: event.id,
      isExistingCustomer: true,
      selectedStateId: event.stateId,
      selectedDistrictId: event.districtId,
      selectedPincodeId: event.pincodeId,
    ));

    try {
      final districts = await _repository.fetchDistricts(event.stateId);
      print("✅ Districts: $districts");

      final selectedDistrict = districts.firstWhere(
            (e) => e["id"].toString() == event.districtId.toString(),
        orElse: () => {},
      );

      final pincodes = await _repository.fetchPincodes(event.districtId);
      print("✅ Pincodes: $pincodes");

      final selectedPincode = pincodes.firstWhere(
            (e) => e["id"].toString() == event.pincodeId.toString(),
        orElse: () => {},
      );

      final selectedStateObj = state.states.firstWhere(
            (e) => e["id"].toString() == event.stateId.toString(),
        orElse: () => {},
      );
       print("✅ States: $selectedStateObj");

      emit(state.copyWith(
        districts: districts,
        pincodesList: pincodes,

        selectedState: selectedStateObj["name"]?.toString(),
        selectedDistrict: selectedDistrict["name"]?.toString(),
        selectedPincode: selectedPincode["code"]?.toString(),
      ));

      print("✅ LOCATION SET SUCCESS");

    } catch (e, stack) {
      print("❌ ERROR: $e");
      print(stack);

      emit(state.copyWith(
        status: NewRegisterStatus.failure,
        message: "Failed to load location for customer",
      ));
    }
  }

  void _onReset(ResetRegisterState event, Emitter<NewRegisterState> emit) {
    _allCustomers.clear();
    emit(NewRegisterState.initial().copyWith(isExistingCustomer: false));
  }

  Future<void> _onLoadLocationData(
      LoadLocationData event, Emitter<NewRegisterState> emit) async {

    emit(state.copyWith(status: NewRegisterStatus.loading));

    try {
      final states = await _repository.fetchStates(1);

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

  Future<void> _onLoadCustomers(
      LoadCustomers event, Emitter<NewRegisterState> emit) async {

    try {
      final customers = await _repository.getCustomers();

      _allCustomers = customers;

      emit(state.copyWith(
        allCustomers: customers,
        searchResults: customers,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NewRegisterStatus.failure,
        message: "Failed to load customers",
      ));
    }
  }

  Future<void> _onSelectState(
      SelectState event, Emitter<NewRegisterState> emit) async {

    emit(state.copyWith(
      selectedState: event.name,
      selectedStateId: event.id,
      selectedDistrict: null,
      selectedDistrictId: null,
      selectedPincode: null,
      selectedPincodeId: null,
      districts: [],
      pincodesList: [],
    ));

    try {
      final districts = await _repository.fetchDistricts(event.id);
      emit(state.copyWith(districts: districts));
    } catch (e) {
      emit(state.copyWith(
        status: NewRegisterStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onSelectDistrict(
      SelectDistrict event, Emitter<NewRegisterState> emit) async {

    emit(state.copyWith(
      selectedDistrict: event.name,
      selectedDistrictId: event.id,
      selectedPincode: null,
      selectedPincodeId: null,
      pincodesList: [],
    ));

    try {
      final pincodes = await _repository.fetchPincodes(event.id);
      emit(state.copyWith(pincodesList: pincodes));
    } catch (e) {
      emit(state.copyWith(
        status: NewRegisterStatus.failure,
        message: e.toString(),
      ));
    }
  }

  void _onSelectPincode(
      SelectPincode event, Emitter<NewRegisterState> emit) {

    emit(state.copyWith(
      selectedPincode: event.code,
      selectedPincodeId: event.id,
    ));
  }

  Future<void> _onSearchCustomer(
      SearchCustomer event, Emitter<NewRegisterState> emit) async {

    try {
      if (_allCustomers.isEmpty) {
        _allCustomers = await _repository.getCustomers();
      }

      final query = event.query.trim().toLowerCase();

      if (query.isEmpty) {
        emit(state.copyWith(searchResults: _allCustomers));
        return;
      }

      final results = _allCustomers.where((e) {
        final phone = (e["phone"] ?? "").toString();
        final name = (e["name"] ?? "").toString().toLowerCase();

        return phone.contains(query) || name.contains(query);
      }).toList();

      emit(state.copyWith(searchResults: results));

    } catch (e) {
      emit(state.copyWith(
        status: NewRegisterStatus.failure,
        message: "Customer search failed",
      ));
    }
  }

  Future<void> _onSubmit(
      NewRegisterSubmit event,
      Emitter<NewRegisterState> emit,
      ) async {

    emit(state.copyWith(status: NewRegisterStatus.loading));

    try {
      final isExisting = state.selectedCustomerId != null;

      if (isExisting) {
        await _repository.addOrderToExistingCustomer(
          customerId: state.selectedCustomerId!,
          panels: event.panels,
        );
      } else {
        await _repository.registerCustomer(
          name: event.name,
          phone: event.phone,
          email: event.email,
          countryId: 1,
          stateId: state.selectedStateId!,
          districtId: state.selectedDistrictId!,
          pincodeId: state.selectedPincodeId!,
          addressLine: event.addressLine,
          panels: event.panels,
          propertyType: event.propertyType,
          rooftopArea: event.rooftopArea,
          electricityBill: event.electricityBill,
        );
      }

       emit(
        state.copyWith(
          status: NewRegisterStatus.success,
          message: isExisting
              ? "Panel added successfully"
              : "Customer registered successfully",
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: NewRegisterStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }
}