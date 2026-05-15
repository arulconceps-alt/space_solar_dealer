import 'dart:io';

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

class LoadTicketByIdEvent extends TicketListDetailsEvent {
  final String ticketId;

  const LoadTicketByIdEvent(this.ticketId);

  @override
  List<Object?> get props => [ticketId];
}


class CreateTicketEvent extends TicketListDetailsEvent {
  final Map<String, dynamic> ticketData;
  final List<File> images;
  
  const CreateTicketEvent(this.ticketData, {this.images = const []});
  
  @override
  List<Object?> get props => [ticketData, images];
}
class LoadPanelsEvent extends TicketListDetailsEvent {
  final String customerId;

  LoadPanelsEvent(this.customerId);
}