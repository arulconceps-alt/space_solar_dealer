import 'package:equatable/equatable.dart';

abstract class TicketListDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTicketsEvent extends TicketListDetailsEvent {
  final String status;
  final int page;
  final String? search; // ✅ ADD THIS

  LoadTicketsEvent({
    this.status = "OPEN",
    this.page = 1,
    this.search,
  });

  @override
  List<Object?> get props => [status, page, search];
}

class RefreshTicketsEvent extends TicketListDetailsEvent {}