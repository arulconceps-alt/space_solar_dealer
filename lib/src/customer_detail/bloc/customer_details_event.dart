abstract class CustomerDetailEvent {}

class LoadCustomerDetail extends CustomerDetailEvent {
  final String id;

  LoadCustomerDetail(this.id);
}