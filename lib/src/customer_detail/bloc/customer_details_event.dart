/*
part of 'customer_bloc.dart';

abstract class CustomerDetailsEvent extends Equatable {
  const CustomerDetailsEvent();

  @override
  List<Object?> get props => [];
}

class RegisterCustomerSubmit extends CustomerDetailsEvent {
  final String name;
  final String phone;
  final String email;
  final String address;
  final List<String> panelIds;

  const RegisterCustomerSubmit({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.panelIds,
  });

  @override
  List<Object?> get props => [name, phone, email, address, panelIds];
}*/
