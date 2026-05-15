import 'package:equatable/equatable.dart';
import 'package:space_solar_dealer/src/common/models/ticket_model.dart';

import '../../common/models/panel_model.dart';


enum TicketListDetailsStatus { initial, loading, success, failure,create }
class TicketListDetailsState extends Equatable {
  final TicketListDetailsStatus status;
  final List<TicketModel> tickets;
  final List<PanelModel> panels;
  final String message;
  final int page;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final TicketModel? selectedTicket;

  const TicketListDetailsState({
    this.status = TicketListDetailsStatus.initial,
    this.tickets = const [],
    this.panels = const [],
    this.message = "",
    this.page = 1,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.selectedTicket,
  });

  TicketListDetailsState copyWith({
    TicketListDetailsStatus? status,
    List<TicketModel>? tickets,
    List<PanelModel>? panels,
    String? message,
    int? page,
    bool? hasReachedMax,
    bool? isLoadingMore,
    TicketModel? selectedTicket,
  }) {
    return TicketListDetailsState(
      status: status ?? this.status,
      tickets: tickets ?? this.tickets,
      panels: panels ?? this.panels,
      message: message ?? this.message,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      selectedTicket: selectedTicket ?? this.selectedTicket,
    );
  }

  @override
  List<Object?> get props => [
        status,
        tickets,
        panels,
        message,
        page,
        hasReachedMax,
        isLoadingMore,
        selectedTicket,
      ];
}