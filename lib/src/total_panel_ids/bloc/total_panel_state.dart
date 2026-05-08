import '../../common/models/panel_model.dart';

enum TotalPanelStatus { initial, loading, success, failure }

class TotalPanelState {
  final TotalPanelStatus status;
  final List<PanelModel> panels;
  final String searchQuery;
  final int currentPage;
  final String? selectedCustomerId;
  final String message;

  const TotalPanelState({
    this.status = TotalPanelStatus.initial,
    this.panels = const [],
    this.searchQuery = '',
    this.currentPage = 1,
    this.selectedCustomerId,
    this.message = '',
  });

  TotalPanelState copyWith({
    TotalPanelStatus? status,
    List<PanelModel>? panels,
    String? searchQuery,
    int? currentPage,
    String? selectedCustomerId,
    String? message,
  }) {
    return TotalPanelState(
      status: status ?? this.status,
      panels: panels ?? this.panels,
      searchQuery: searchQuery ?? this.searchQuery,
      currentPage: currentPage ?? this.currentPage,
      selectedCustomerId:
          selectedCustomerId ?? this.selectedCustomerId,
      message: message ?? this.message,
    );
  }
}