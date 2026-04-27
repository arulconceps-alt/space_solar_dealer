part of 'customer_list_bloc.dart';

abstract class CustomerListEvent extends Equatable {
  const CustomerListEvent();

  @override
  List<Object?> get props => [];
}

/// 🔥 Load API
class LoadCustomers extends CustomerListEvent {}

/// 🔍 Search
class SearchCustomers extends CustomerListEvent {
  final String query;

  const SearchCustomers(this.query);

  @override
  List<Object?> get props => [query];
}