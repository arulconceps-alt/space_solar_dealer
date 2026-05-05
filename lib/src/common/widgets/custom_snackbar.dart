import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/common/bloc/alert/alert_state.dart';


class CustomSnackBar {
  static void show(BuildContext context, AlertState state) {
    final color = _getSnackbarColor(state.type);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating, // Provides a modern, "best app" feel
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static Color _getSnackbarColor(AlertType type) {
    switch (type) {
      case AlertType.success: return Colors.green;
      case AlertType.failure: return Colors.red;
      case AlertType.network: return Colors.orange;
      case AlertType.server: return Colors.blueGrey;
    }
  }
}