import 'package:equatable/equatable.dart';
import 'package:space_solar_dealer/src/common/models/ticket_model.dart';

import '../../common/models/panel_model.dart';


enum TicketListDetailsStatus { initial, loading, success, failure,create }

class TicketListDetailsState extends Equatable {
  final TicketListDetailsStatus status;
  final List<TicketModel> tickets;
  final List<PanelModel> panels; // ✅ ADD THIS
  final String message;

  const TicketListDetailsState({
    this.status = TicketListDetailsStatus.initial,
    this.tickets = const [],
    this.panels = const [], // ✅ ADD THIS
    this.message = "",
  });

  TicketListDetailsState copyWith({
    TicketListDetailsStatus? status,
    List<TicketModel>? tickets,
    List<PanelModel>? panels,
    String? message,
  }) {
    return TicketListDetailsState(
      status: status ?? this.status,
      tickets: tickets ?? this.tickets,
      panels: panels ?? this.panels,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, tickets, panels, message];
}