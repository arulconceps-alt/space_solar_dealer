import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_solar_dealer/src/dashboard/bloc/dashboard_event.dart';
import 'package:space_solar_dealer/src/dashboard/bloc/dashboard_state.dart';
import 'package:space_solar_dealer/src/dashboard/repo/dashboard_repositary.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repository;

  DashboardBloc(this.repository) : super(const DashboardState()) {
    on<LoadDashboardEvent>(_onLoadDashboard);
  }

  Future<void> _onLoadDashboard(
    LoadDashboardEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(status: DashboardStatus.loading));

    try {
      final data = await repository.getDashboard();

      emit(state.copyWith(
        status: DashboardStatus.success,
        dashboard: data,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: DashboardStatus.failure,
        message: e.toString(),
      ));
    }
  }
}