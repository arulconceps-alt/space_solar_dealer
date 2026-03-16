import 'package:flutter/material.dart';

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionCard('Add \nMoney'),
          _buildActionCard('My \nResults'),
          _buildActionCard('Customer\nSupport'),
        ],
      ),
    );
  }

  Widget _buildActionCard(String label) {
    return Container(
      width: 103,
      height: 102,
      decoration: ShapeDecoration(
        color: const Color(0xFF24232A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontStyle: FontStyle.italic,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 1.17,
          ),
        ),
      ),
    );
  }
}
