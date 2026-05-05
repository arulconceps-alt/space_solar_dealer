
enum DashboardStatus {
  initial,
  loading,
  success,
  failure,
}

class DashboardState {
  final DashboardStatus status;
  final String message;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.message = '',
  });

  DashboardState copyWith({
    DashboardStatus? status,
    String? message,
  }) {
    return DashboardState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}