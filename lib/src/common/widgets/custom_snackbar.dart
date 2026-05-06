import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/common/bloc/alert/alert_state.dart';

class CustomSnackBar {
  static void show(BuildContext context, AlertState state) {
    final color = _getSnackbarColor(state.type);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          state.message,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        elevation: 6,
      ),
    );
  }

  static Color _getSnackbarColor(AlertType type) {
    switch (type) {
      case AlertType.success:
        return Colors.green;
      case AlertType.failure:
        return Colors.red;
      case AlertType.network:
        return Colors.orange;
      case AlertType.server:
        return Colors.blueGrey;
    }
  }
}