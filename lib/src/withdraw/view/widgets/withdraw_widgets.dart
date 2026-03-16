import 'package:flutter/material.dart';

// REUSABLE TILE
class PaymentMethodTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget child;
  final Widget icon;

  const PaymentMethodTile({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.child,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF24232A),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: icon),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: isSelected ? Colors.white : Colors.white24,
                ),
              ],
            ),
            if (isSelected) ...[const SizedBox(height: 16), child],
          ],
        ),
      ),
    );
  }
}

// FORMS
class WithdrawUpiForm extends StatelessWidget {
  final String upiId;
  final VoidCallback onRedeem;
  final VoidCallback onEdit;
  const WithdrawUpiForm({
    super.key,
    required this.upiId,
    required this.onRedeem,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildVerifiedBox(upiId),
        const SizedBox(height: 12),
        _buildActionRow(onRedeem, onEdit),
      ],
    );
  }
}

class WithdrawAmazonForm extends StatelessWidget {
  final String phoneNumber;
  final VoidCallback onRedeem;
  final VoidCallback onEdit;
  const WithdrawAmazonForm({
    super.key,
    required this.phoneNumber,
    required this.onRedeem,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildVerifiedBox('+91 - $phoneNumber'),
        const SizedBox(height: 12),
        _buildActionRow(onRedeem, onEdit),
      ],
    );
  }
}

class WithdrawBankForm extends StatelessWidget {
  final String accountHolder, accountNo, ifscCode;
  final VoidCallback onRedeem;
  final VoidCallback onEdit;
  const WithdrawBankForm({
    super.key,
    required this.accountHolder,
    required this.accountNo,
    required this.ifscCode,
    required this.onRedeem,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSimpleBox(accountHolder),
        const SizedBox(height: 8),
        _buildSimpleBox(accountNo),
        const SizedBox(height: 8),
        _buildVerifiedBox(ifscCode),
        const SizedBox(height: 12),
        _buildActionRow(onRedeem, onEdit),
      ],
    );
  }
}

// HELPERS
Widget _buildVerifiedBox(String txt) => Container(
  width: double.infinity,
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: const Color(0xFF313038),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Row(
    children: [
      Expanded(
        child: Text(txt, style: const TextStyle(color: Colors.white)),
      ),
      Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: Color(0xFF34C759),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, size: 14, color: Colors.white),
      ),
    ],
  ),
);

Widget _buildSimpleBox(String txt) => Container(
  width: double.infinity,
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: const Color(0xFF313038),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Text(txt, style: const TextStyle(color: Colors.white)),
);

Widget _buildActionRow(VoidCallback onRedeem, VoidCallback onEdit) => Row(
  children: [
    Expanded(child: _btn('Redeem Now', onRedeem, true)),
    const SizedBox(width: 12),
    Expanded(child: _btn('Edit', onEdit, false)),
  ],
);

// FIX: Using GestureDetector for more reliable touch detection
Widget _btn(
  String label,
  VoidCallback onTap,
  bool grad, {
  double height = 40,
}) => GestureDetector(
  onTap: onTap,
  child: Container(
    height: height,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      gradient: grad
          ? const LinearGradient(colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)])
          : null,
      color: grad ? null : const Color(0xFF313038),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      label,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  ),
);

class LayoutAddMoney extends StatelessWidget {
  final TextEditingController amountController;
  final String balance;
  final VoidCallback onWithdraw;
  const LayoutAddMoney({
    super.key,
    required this.amountController,
    required this.balance,
    required this.onWithdraw,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'REDEEMABLE BALANCE',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            Text(
              '₹$balance',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF24232A),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Redeem Amount',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF313038),
                  prefixText: '₹ ',
                  prefixStyle: const TextStyle(color: Color(0xFFDFC45C)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Min redeemable amount is ₹100',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _btn('Withdraw Money', onWithdraw, true, height: 48),
      ],
    );
  }
}
