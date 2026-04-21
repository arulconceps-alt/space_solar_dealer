part of 'new_register_bloc.dart';

abstract class NewRegisterEvent extends Equatable {
  const NewRegisterEvent();

  @override
  List<Object?> get props => [];
}

class NewRegisterSubmit extends NewRegisterEvent {
  final String name;
  final String phone;
  final String email;
  final String address;
  final String city;
  final String state;
  final String district;
  final String area;
  final List<String> panels;
  final String parentId;

  const NewRegisterSubmit({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.city,
    required this.state,
    required this.district,
    required this.area,
    required this.panels,
    required this.parentId,
  });

  @override
  List<Object?> get props =>
      [name, phone, email, address, city, state, district, area, panels, parentId];
}
class LoadLocationData extends NewRegisterEvent {}

class SelectState extends NewRegisterEvent {
  final String state;
  const SelectState(this.state);
}

class SelectDistrict extends NewRegisterEvent {
  final String district;
  const SelectDistrict(this.district);
}
class SearchCustomer extends NewRegisterEvent {
  final String query;
  SearchCustomer(this.query);
}
class ResetRegisterState extends NewRegisterEvent {
  const ResetRegisterState();

  @override
  List<Object?> get props => [];
}