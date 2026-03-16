import 'package:flutter/material.dart';

import '../../app/color_palette.dart';


class CustomSuccessSnackbar extends StatelessWidget {
  final String message;

  const CustomSuccessSnackbar({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.9,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: ColorPalette.snackbar,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1927245D),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Color(0x1927245D),
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [

          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),

          const Icon(
            Icons.close,
            color: Colors.white,
            size: 20,
          ),

        ],
      ),
    );
  }
}