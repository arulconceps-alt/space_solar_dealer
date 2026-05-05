part of 'new_register_bloc.dart';

abstract class NewRegisterEvent extends Equatable {
  const NewRegisterEvent();

  @override
  List<Object?> get props => [];
}

// ✅ LOAD LOCATION
class LoadLocationData extends NewRegisterEvent {}

// ✅ STATE
class SelectState extends NewRegisterEvent {
  final String name;
  final int id;

  const SelectState(this.name, this.id);

  @override
  List<Object?> get props => [name, id];
}

// ✅ DISTRICT
class SelectDistrict extends NewRegisterEvent {
  final String name;
  final int id;

  const SelectDistrict(this.name, this.id);

  @override
  List<Object?> get props => [name, id];
}

// ✅ PINCODE
class SelectPincode extends NewRegisterEvent {
  final int id;
  final String code;

  const SelectPincode({
    required this.id,
    required this.code,
  });

  @override
  List<Object?> get props => [id, code];
}

// ✅ SEARCH CUSTOMER
class SearchCustomer extends NewRegisterEvent {
  final String query;
  const SearchCustomer(this.query);

  @override
  List<Object?> get props => [query];
}

// ✅ LOAD CUSTOMERS
class LoadCustomers extends NewRegisterEvent {}

// ✅ RESET
class ResetRegisterState extends NewRegisterEvent {}

// ✅ ✅ FIXED EXISTING CUSTOMER EVENT
class SelectExistingCustomer extends NewRegisterEvent {
  final String id;
  final int stateId;
  final int districtId;
  final int pincodeId;

  const SelectExistingCustomer({
    required this.id,
    required this.stateId,
    required this.districtId,
    required this.pincodeId,
  });

  @override
  List<Object?> get props => [id, stateId, districtId, pincodeId];
}

// ✅ SUBMIT
class NewRegisterSubmit extends NewRegisterEvent {
  final String name;
  final String phone;
  final String email;
  final String addressLine;
  final int stateId;
  final int districtId;
  final int pincodeId;
  final List<String> panels;

  final String propertyType;
  final double rooftopArea;
  final double electricityBill;

  const NewRegisterSubmit({
    required this.name,
    required this.phone,
    required this.email,
    required this.addressLine,
    required this.stateId,
    required this.districtId,
    required this.pincodeId,
    required this.panels,
    required this.propertyType,
    required this.rooftopArea,
    required this.electricityBill,
  });

  @override
  List<Object?> get props => [
    name,
    phone,
    email,
    addressLine,
    stateId,
    districtId,
    pincodeId,
    panels,
    propertyType,
    rooftopArea,
    electricityBill,
  ];
}