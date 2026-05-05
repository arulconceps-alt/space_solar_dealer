import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc
    extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc()
      : super(
    const DashboardState(),
  ) {
    on<DashboardLoadingEvent>(
      _onDashboardLoading,
    );

    on<DashboardLoadedEvent>(
      _onDashboardLoaded,
    );
  }

  Future<void> _onDashboardLoading(
      DashboardLoadingEvent event,
      Emitter<DashboardState> emit,
      ) async {
    emit(
      state.copyWith(
        status: DashboardStatus.loading,
      ),
    );

    /// API CALL
    await Future.delayed(
      const Duration(seconds: 2),
    );

    emit(
      state.copyWith(
        status: DashboardStatus.success,
      ),
    );
  }

  void _onDashboardLoaded(
      DashboardLoadedEvent event,
      Emitter<DashboardState> emit,
      ) {
    emit(
      state.copyWith(
        status: DashboardStatus.success,
      ),
    );
  }
}