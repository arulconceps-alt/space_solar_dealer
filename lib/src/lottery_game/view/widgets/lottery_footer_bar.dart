import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LotteryFooterBar extends StatelessWidget {
  final double totalAmount;
  final int totalNumbers;
  final VoidCallback onToggle;

  const LotteryFooterBar({
    super.key,
    required this.totalAmount,
    required this.totalNumbers,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1C1B20),
        border: Border(top: BorderSide(width: 2, color: Color(0xFF24232A))),
      ),
      child: SafeArea(
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              // CLICKABLE AREA (Icon + Text)
              GestureDetector(
                onTap: onToggle,
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    SvgPicture.asset("assets/images/icons/leadingicon.svg"),
                    const SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₹${totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '$totalNumbers numbers',
                          style: const TextStyle(
                            color: Color(0xFF9F9F9F),
                            fontSize: 12,
                            fontFamily: 'DM Sans',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // PAY NOW BUTTON
              Container(
                width: 114,
                height: 44,
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Pay Now',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
