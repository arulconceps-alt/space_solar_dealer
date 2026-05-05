abstract class TotalPanelEvent {}

class LoadPanelsEvent extends TotalPanelEvent {
  final int page;
  final int limit;

  LoadPanelsEvent({this.page = 1, this.limit = 10});
}

class SearchPanelEvent extends TotalPanelEvent {
  final String query;

  SearchPanelEvent(this.query);
}