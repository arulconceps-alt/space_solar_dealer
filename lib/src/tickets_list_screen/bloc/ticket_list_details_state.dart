import 'package:equatable/equatable.dart';
import 'package:space_solar_dealer/src/common/models/ticket_model.dart';


enum TicketListDetailsStatus { initial, loading, success, failure }

class TicketListDetailsState extends Equatable {
  final TicketListDetailsStatus status;
  final List<TicketModel> tickets;
  final String message;

  const TicketListDetailsState({
    this.status = TicketListDetailsStatus.initial,
    this.tickets = const [],
    this.message = "",
  });

  TicketListDetailsState copyWith({
    TicketListDetailsStatus? status,
    List<TicketModel>? tickets,
    String? message,
  }) {
    return TicketListDetailsState(
      status: status ?? this.status,
      tickets: tickets ?? this.tickets,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, tickets, message];
}