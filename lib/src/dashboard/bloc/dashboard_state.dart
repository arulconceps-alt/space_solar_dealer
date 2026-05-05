import 'package:space_solar_dealer/src/common/models/dashboard_model.dart';

enum DashboardStatus {
  initial,
  loading,
  success,
  failure,
}

class DashboardState {
  final DashboardStatus status;
  final String message;
  final DashboardModel? dashboard;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.message = '',
    this.dashboard,
  });

  DashboardState copyWith({
    DashboardStatus? status,
    String? message,
    DashboardModel? dashboard,
  }) {
    return DashboardState(
      status: status ?? this.status,
      message: message ?? this.message,
      dashboard: dashboard ?? this.dashboard,
    );
  }
}