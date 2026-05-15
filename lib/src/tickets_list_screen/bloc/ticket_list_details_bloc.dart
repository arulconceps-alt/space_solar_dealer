import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_solar_dealer/src/common/models/ticket_model.dart';
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
      final data = await repository.getPanelIds(event.customerId);
      emit(state.copyWith(panels: data));
       on<LoadTicketByIdEvent>(_onLoadTicketById);
    });
  }

 Future<void> _onCreateTicket(
  CreateTicketEvent event,
  Emitter<TicketListDetailsState> emit,
) async {
  try {
    emit(state.copyWith(status: TicketListDetailsStatus.loading));
    print("🔥 CREATE EVENT STARTED");
    final data = event.ticketData;
    final response = await repository.createTicket(
      customerId: data["customerId"],
      title: data["title"],
      description: data["description"],
      category: data["category"] ?? "MAINTENANCE",
      priority: data["priority"] ?? "HIGH",
      scheduledAt: data["scheduledAt"],
      products: List<Map<String, dynamic>>.from(data["products"]),
      images: event.images, 
    );
    print("✅ CREATE SUCCESS RESPONSE: $response");
    final newTicket = TicketModel.fromJson(response);
    emit(state.copyWith(
      status: TicketListDetailsStatus.create,
      tickets: [newTicket],
    ));
    add(LoadTicketsEvent());
  } catch (e, stackTrace) {
    print("❌ CREATE ERROR: $e");
    print(stackTrace);
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
    final isFirstPage = event.page == 1;

    if (isFirstPage) {
      emit(state.copyWith(
        status: TicketListDetailsStatus.loading,
        page: 1,
        hasReachedMax: false,
      ));
    } else {
      emit(state.copyWith(isLoadingMore: true));
    }

    await Future.delayed(const Duration(seconds: 1));


    final tickets = await repository.fetchTickets(page: event.page);

    final hasReachedMax = tickets.length < 10;

    final updatedList = isFirstPage
        ? tickets
        : [...state.tickets, ...tickets];

    emit(state.copyWith(
      status: TicketListDetailsStatus.success,
      tickets: updatedList,
      page: event.page,
      hasReachedMax: hasReachedMax,
      isLoadingMore: false,
    ));
  } catch (e) {
    emit(state.copyWith(
      status: TicketListDetailsStatus.failure,
      message: e.toString(),
      isLoadingMore: false,
    ));
  }
}

 Future<void> _onLoadTicketById(
  LoadTicketByIdEvent event,
  Emitter<TicketListDetailsState> emit,
) async {
  try {
    emit(state.copyWith(status: TicketListDetailsStatus.loading));

    final TicketModel ticket =
        await repository.getTicketDetails(event.ticketId);

    emit(state.copyWith(
      status: TicketListDetailsStatus.success,
      selectedTicket: ticket,
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