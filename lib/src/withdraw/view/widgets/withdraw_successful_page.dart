import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/app/route_names.dart'; // Ensure path is correct

class WithdrawSuccessfulPage extends StatefulWidget {
  const WithdrawSuccessfulPage({super.key});

  @override
  State<WithdrawSuccessfulPage> createState() => _WithdrawSuccessfulPageState();
}

class _WithdrawSuccessfulPageState extends State<WithdrawSuccessfulPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Auto-redirect to Home (or Wallet) after 5 seconds
    _timer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        context.goNamed(RouteName.home);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel timer to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1B20),
      body: Center(
        child: Container(
          width: 328,
          height: 382,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated GIF Container (Matches your previous success screens)
              Container(
                width: 148,
                height: 148,
                decoration: ShapeDecoration(
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/gifs/success_check.gif',
                    ), // Path to your green check gif
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(74),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Text Section
              const Text(
                'Withdraw Successful',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                  letterSpacing: 0.16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'will redirect back automatically in 5 secs...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withAlpha(153), // 60% Opacity
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 1.71,
                  letterSpacing: 0.14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
