import 'package:flutter/material.dart';

class PaymentMethodCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const PaymentMethodCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(15.56),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
