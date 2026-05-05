import 'package:flutter/material.dart';

class TicketSuccessAnimatedTick extends StatefulWidget {
  final double scale;
  const TicketSuccessAnimatedTick({super.key, required this.scale});

  @override
  State<TicketSuccessAnimatedTick> createState() => _TicketSuccessAnimatedTick();
}

class _TicketSuccessAnimatedTick extends State<TicketSuccessAnimatedTick>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> scaleAnim;
  late Animation<double> fadeAnim;

  double s(double v) => v * widget.scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    scaleAnim = Tween(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart),
    );

    fadeAnim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: s(110),
      height: s(110),
      decoration: const BoxDecoration(
        color: Color(0x4C319F43),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: FadeTransition(
          opacity: fadeAnim,
          child: ScaleTransition(
            scale: scaleAnim,
            child: Image.asset(
              "assets/images/success/tick_circle_outline.png",
              width: s(44),
              height: s(44),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}