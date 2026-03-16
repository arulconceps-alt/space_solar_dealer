import 'package:flutter/material.dart';

class OtherPaymentMethodsCard extends StatelessWidget {
  const OtherPaymentMethodsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 334.44,
      padding: const EdgeInsets.symmetric(vertical: 11.67),
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(7.78),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.56, vertical: 7.78),
            child: Text(
              'Other',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.56,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _buildRow('UPI', true),
          _buildRow('Debit/Credit Cards', false),
          _buildRow('Net Banking', false),
        ],
      ),
    );
  }

  Widget _buildRow(String title, bool hasIcon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.56, vertical: 11.67),
      child: Row(
        children: [
          Container(
            width: 23.33,
            height: 23.33,
            decoration: BoxDecoration(
              color: hasIcon ? Colors.white : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 11.67),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 15.56),
            ),
          ),
          const SizedBox(width: 19.44, height: 19.44),
        ],
      ),
    );
  }
}
