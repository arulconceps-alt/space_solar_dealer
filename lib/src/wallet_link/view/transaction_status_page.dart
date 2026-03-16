import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';

class TransactionStatusPage extends StatefulWidget {
  final String title;
  final String subtitle;
  final String assetGif; // Path to your local gif
  final bool isPending;

  const TransactionStatusPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.assetGif,
    this.isPending = false,
  });

  @override
  State<TransactionStatusPage> createState() => _TransactionStatusPageState();
}

class _TransactionStatusPageState extends State<TransactionStatusPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Auto-redirect logic for Success
    if (!widget.isPending && widget.title.contains('Successful')) {
      _timer = Timer(const Duration(seconds: 5), () {
        if (mounted) {
          context.goNamed(RouteName.home);
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
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
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- GIF Animation Container ---
              Container(
                width: 148,
                height: 148,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    // Replace with your local asset paths
                    image: AssetImage(widget.assetGif),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(74),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // --- Text Section ---
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 296,
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                        letterSpacing: 0.16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 296,
                    child: Text(
                      widget.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withAlpha(153),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.71,
                        letterSpacing: 0.14,
                      ),
                    ),
                  ),
                ],
              ),

              // --- Pending Button ---
              if (widget.isPending) ...[
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => context.goNamed(RouteName.home),
                  child: Container(
                    height: 36,
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
