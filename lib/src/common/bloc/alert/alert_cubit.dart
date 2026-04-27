import 'package:flutter_bloc/flutter_bloc.dart';
import 'alert_state.dart';

class AlertCubit extends Cubit<AlertState?> {
  AlertCubit() : super(null);

  void showSuccess(String msg) => emit(AlertState(message: msg, type: AlertType.success, timestamp: DateTime.now()));
  void showFailure(String msg) => emit(AlertState(message: msg, type: AlertType.failure, timestamp: DateTime.now()));
  void showNetworkError() => emit(AlertState(message: "No Internet Connection", type: AlertType.network, timestamp: DateTime.now()));
  void showServerError() => emit(AlertState(message: "Server Error. Please try again.", type: AlertType.server, timestamp: DateTime.now()));
}