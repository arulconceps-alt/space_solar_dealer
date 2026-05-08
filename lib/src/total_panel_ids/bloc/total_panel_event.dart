import 'package:equatable/equatable.dart';

abstract class TotalPanelEvent extends Equatable {
  const TotalPanelEvent();

  @override
  List<Object?> get props => [];
}

class LoadPanelsEvent extends TotalPanelEvent {
  final int page;
  final String? customerId;

  const LoadPanelsEvent({
    this.page = 1,
    this.customerId,
  });

  @override
  List<Object?> get props => [page, customerId];
}

class SearchPanelEvent extends TotalPanelEvent {
  final String query;

  const SearchPanelEvent(this.query);

  @override
  List<Object?> get props => [query];
}