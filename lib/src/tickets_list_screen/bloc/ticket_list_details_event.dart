import 'package:equatable/equatable.dart';

abstract class TicketListDetailsEvent extends Equatable {
  const TicketListDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadTicketsEvent extends TicketListDetailsEvent {
  final int page;
  final String? search;

  const LoadTicketsEvent({
    this.page = 1,
    this.search,
  });

  @override
  List<Object?> get props => [page, search];
}

class RefreshTicketsEvent extends TicketListDetailsEvent {
  const RefreshTicketsEvent();
}

class CreateTicketEvent extends TicketListDetailsEvent {
  final Map<String, dynamic> ticketData;

  const CreateTicketEvent(this.ticketData);

  @override
  List<Object?> get props => [ticketData];
}
class LoadPanelsEvent extends TicketListDetailsEvent {}