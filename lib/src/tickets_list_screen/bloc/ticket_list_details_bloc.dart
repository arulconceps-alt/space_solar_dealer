import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/bloc/ticket_list_details_event.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/bloc/ticket_list_details_state.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/repo/ticket_list_details_repositary.dart';


class TicketListDetailsBloc
    extends Bloc<TicketListDetailsEvent, TicketListDetailsState> {

  final TicketListDetailsRepositary repository;

  TicketListDetailsBloc(this.repository)
      : super(const TicketListDetailsState()) {
    on<LoadTicketsEvent>(_onLoadTickets);
    on<RefreshTicketsEvent>(_onRefreshTickets);
    on<CreateTicketEvent>(_onCreateTicket);
    on<LoadPanelsEvent>((event, emit) async {
      final data = await repository.getPanelIds();
      emit(state.copyWith(panels: data));
    });
  }

  Future<void> _onCreateTicket(
      CreateTicketEvent event,
      Emitter<TicketListDetailsState> emit,
      ) async {
    try {
      final data = event.ticketData;

      await repository.createTicket(
        customerId: data["customerId"],
        title: data["title"],
        description: data["description"],
        category: data["category"],
        priority: data["priority"],
        scheduledAt: data["scheduledAt"],
        products: List<Map<String, dynamic>>.from(data["products"]),
      );

      add(LoadTicketsEvent());
    } catch (e) {
      emit(state.copyWith(
        status: TicketListDetailsStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onLoadTickets(
      LoadTicketsEvent event,
      Emitter<TicketListDetailsState> emit,
      ) async {
    try {
      emit(state.copyWith(status: TicketListDetailsStatus.loading));

      final tickets = await repository.fetchTickets(
        page: event.page,
      );

      emit(state.copyWith(
        status: TicketListDetailsStatus.success,
        tickets: tickets,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TicketListDetailsStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onRefreshTickets(
      RefreshTicketsEvent event,
      Emitter<TicketListDetailsState> emit,
      ) async {
    add(LoadTicketsEvent());
  }
}