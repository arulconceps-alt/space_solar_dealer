import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_solar_dealer/src/total_panel_ids/bloc/total_panel_event.dart';
import 'package:space_solar_dealer/src/total_panel_ids/bloc/total_panel_state.dart';
import '../repo/total_panel_repositary.dart';

class TotalPanelBloc extends Bloc<TotalPanelEvent, TotalPanelState> {
  final TotalPanelRepositary repository;

  TotalPanelBloc(this.repository) : super(const TotalPanelState()) {
    on<LoadPanelsEvent>(_onLoadPanels);
    on<SearchPanelEvent>(_onSearch);
  }

  Future<void> _onLoadPanels(
      LoadPanelsEvent event,
      Emitter<TotalPanelState> emit,
      ) async {
    try {
      emit(state.copyWith(status: TotalPanelStatus.loading));

      final data = await repository.getPanelIds();

      emit(state.copyWith(
        status: TotalPanelStatus.success,
        panels: data,
        currentPage: event.page,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TotalPanelStatus.failure,
        message: e.toString(),
      ));
    }
  }

  void _onSearch(
      SearchPanelEvent event,
      Emitter<TotalPanelState> emit,
      ) {
    emit(state.copyWith(searchQuery: event.query));
  }
}