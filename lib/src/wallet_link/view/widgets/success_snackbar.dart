import 'package:flutter/material.dart';

class SuccessSnackbar extends StatelessWidget {
  const SuccessSnackbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF37B158),
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1927245D),
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: const Row(
        children: [
          Expanded(
            child: Text(
              'Successfully Linked Your Wallet',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Icon(Icons.check_circle_outline, color: Colors.white),
        ],
      ),
    );
  }
}
