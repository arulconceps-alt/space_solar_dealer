import 'package:flutter/material.dart';

import '../common/widgets/custom_success_snackbar.dart';


void showSuccessSnackbar(
    BuildContext context,
    String message,
    ) {

  ScaffoldMessenger.of(context).showSnackBar(

    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),

      content: CustomSuccessSnackbar(
        message: message,
      ),
    ),

  );

}