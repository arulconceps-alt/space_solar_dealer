part of 'new_register_bloc.dart';

enum NewRegisterStatus { initial, loading, success, failure }

class NewRegisterState extends Equatable {
  final NewRegisterStatus status;
  final String message;

  final List<Map<String, dynamic>> states;
  final List<Map<String, dynamic>> districts;
  final List<Map<String, dynamic>> pincodesList;
  final List<Map<String, dynamic>> searchResults;
  final List<Map<String, dynamic>> allCustomers;

  final String? selectedState;
  final String? selectedDistrict;
  final String? selectedPincode;

  final int? selectedStateId;
  final int? selectedDistrictId;
  final int? selectedPincodeId;

  final String? selectedCustomerId;

  // ✅ ADD THIS (IMPORTANT)
  final bool isExistingCustomer;

  const NewRegisterState({
    this.status = NewRegisterStatus.initial,
    this.message = '',
    this.states = const [],
    this.districts = const [],
    this.pincodesList = const [],
    this.searchResults = const [],
    this.allCustomers = const [],
    this.selectedState,
    this.selectedDistrict,
    this.selectedPincode,
    this.selectedStateId,
    this.selectedDistrictId,
    this.selectedPincodeId,
    this.selectedCustomerId,

    // ✅ ADD DEFAULT VALUE
    this.isExistingCustomer = false,
  });

  factory NewRegisterState.initial() => const NewRegisterState();

  NewRegisterState copyWith({
    NewRegisterStatus? status,
    String? message,
    List<Map<String, dynamic>>? states,
    List<Map<String, dynamic>>? districts,
    List<Map<String, dynamic>>? pincodesList,
    List<Map<String, dynamic>>? searchResults,
    List<Map<String, dynamic>>? allCustomers,
    String? selectedState,
    String? selectedDistrict,
    String? selectedPincode,
    int? selectedStateId,
    int? selectedDistrictId,
    int? selectedPincodeId,
    String? selectedCustomerId,

    // ✅ ADD THIS
    bool? isExistingCustomer,
  }) {
    return NewRegisterState(
      status: status ?? this.status,
      message: message ?? this.message,
      states: states ?? this.states,
      districts: districts ?? this.districts,
      pincodesList: pincodesList ?? this.pincodesList,
      searchResults: searchResults ?? this.searchResults,
      allCustomers: allCustomers ?? this.allCustomers,

      selectedState: selectedState ?? this.selectedState,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      selectedPincode: selectedPincode ?? this.selectedPincode,

      selectedStateId: selectedStateId ?? this.selectedStateId,
      selectedDistrictId: selectedDistrictId ?? this.selectedDistrictId,
      selectedPincodeId: selectedPincodeId ?? this.selectedPincodeId,

      selectedCustomerId: selectedCustomerId ?? this.selectedCustomerId,

      // ✅ FIX HERE (IMPORTANT)
      isExistingCustomer: isExistingCustomer ?? this.isExistingCustomer,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    states,
    districts,
    pincodesList,
    searchResults,
    allCustomers,
    selectedState,
    selectedDistrict,
    selectedPincode,
    selectedStateId,
    selectedDistrictId,
    selectedPincodeId,
    selectedCustomerId,

    // ✅ ADD THIS
    isExistingCustomer,
  ];
}