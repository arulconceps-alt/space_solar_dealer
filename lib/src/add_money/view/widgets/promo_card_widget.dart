import 'package:flutter/material.dart';

class PromoCardWidget extends StatelessWidget {
  final String code;
  final String description;
  final String minDeposit;
  final String validity;
  final VoidCallback onApply;

  const PromoCardWidget({
    super.key,
    required this.code,
    required this.description,
    required this.minDeposit,
    required this.validity,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF313038),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Text(code, style: const TextStyle(color: Colors.white)),
              ),
              _buildApplyButton(),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Min Deposit : $minDeposit',
                style: const TextStyle(color: Colors.white60, fontSize: 12),
              ),
              Text(
                'Valid: $validity',
                style: const TextStyle(color: Colors.white60, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildApplyButton() {
    return GestureDetector(
      onTap: onApply,
      child: Container(
        width: 64,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Apply',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
