import '../../common/models/panel_model.dart';

enum TotalPanelStatus { initial, loading, success, failure }

class TotalPanelState {
  final TotalPanelStatus status;
  final List<PanelModel> panels;
  final String message;
  final String searchQuery;
  final int currentPage;

  const TotalPanelState({
    this.status = TotalPanelStatus.initial,
    this.panels = const [],
    this.message = "",
    this.searchQuery = "",
    this.currentPage = 1,
  });

  TotalPanelState copyWith({
    TotalPanelStatus? status,
    List<PanelModel>? panels,
    String? message,
    String? searchQuery,
    int? currentPage,
  }) {
    return TotalPanelState(
      status: status ?? this.status,
      panels: panels ?? this.panels,
      message: message ?? this.message,
      searchQuery: searchQuery ?? this.searchQuery,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}