part of 'new_register_bloc.dart';

abstract class NewRegisterEvent extends Equatable {
  const NewRegisterEvent();

  @override
  List<Object?> get props => [];
}

class LoadLocationData extends NewRegisterEvent {}

class SelectState extends NewRegisterEvent {
  final String name;
  final int id;

  const SelectState(this.name, this.id);

  @override
  List<Object?> get props => [name, id];
}

class SelectDistrict extends NewRegisterEvent {
  final String name;
  final int id;

  const SelectDistrict(this.name, this.id);

  @override
  List<Object?> get props => [name, id];
}

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

class SearchCustomer extends NewRegisterEvent {
  final String query;
  const SearchCustomer(this.query);
}

class NewRegisterSubmit extends NewRegisterEvent {
  final String name;
  final String phone;
  final String email; // ✅ ADD THIS
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
    required this.email, // ✅ ADD
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
    email, // ✅ ADD
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
class LoadCustomers extends NewRegisterEvent {}
class ResetRegisterState extends NewRegisterEvent {}
class SelectExistingCustomer extends NewRegisterEvent {
  final String? id;
  const SelectExistingCustomer(this.id);

  @override
  List<Object?> get props => [id];
}
