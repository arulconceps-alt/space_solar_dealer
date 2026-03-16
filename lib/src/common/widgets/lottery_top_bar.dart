import 'package:flutter/material.dart';

class LotteryTopBar extends StatelessWidget {
  final String title;
  final Widget? leftIcon;
  final Widget? rightIcon;

  const LotteryTopBar({
    super.key,
    required this.title,
    this.leftIcon,
    this.rightIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          /// Left Icon
          SizedBox(width: 24, height: 24, child: leftIcon ?? const SizedBox()),

          /// Center Title
          Expanded(
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500,
                  height: 1.30,
                  letterSpacing: -0.17,
                ),
              ),
            ),
          ),

          /// Right Icon
          SizedBox(width: 24, height: 24, child: rightIcon ?? const SizedBox()),
        ],
      ),
    );
  }
}
