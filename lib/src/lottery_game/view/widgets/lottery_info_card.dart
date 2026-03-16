import 'dart:async';
import 'package:flutter/material.dart';

/// Lottery Info Card showing countdown in small boxes and big numbers
class LotteryInfoCard extends StatefulWidget {
  final String drawTime; // just a label

  const LotteryInfoCard({super.key, required this.drawTime});

  @override
  State<LotteryInfoCard> createState() => _LotteryInfoCardState();
}

class _LotteryInfoCardState extends State<LotteryInfoCard> {
  late Timer _timer;
  Duration _remaining = Duration(
    hours: 1,
    minutes: 23,
    seconds: 45,
  ); // initial countdown

  // Big boxes numbers (static for now)
  final List<int> _bigNumbers = [5, 3, 1];

  @override
  void initState() {
    super.initState();

    // Timer to decrement countdown
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (_remaining.inSeconds > 0) {
          _remaining -= const Duration(seconds: 1);
        }
      });
    });
  }

  /// Digits for small boxes [H,H,M,M,S,S]
  List<String> get _smallDigits {
    final hours = _remaining.inHours.toString().padLeft(2, '0');
    final minutes = (_remaining.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (_remaining.inSeconds % 60).toString().padLeft(2, '0');
    return [...hours.split(''), ...minutes.split(''), ...seconds.split('')];
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140,
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: const Color(0xFF24232A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        children: [
          /// Top: Lottery Info + Countdown in small boxes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: Lottery Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Kerala Lottery',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '19/01/2026',
                    style: TextStyle(
                      color: Color(0xFF9F9F9F),
                      fontSize: 12,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              // Right: Time remaining small boxes
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Time remaining',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: List.generate(_smallDigits.length, (index) {
                      return Row(
                        children: [
                          SmallBox(value: _smallDigits[index]),
                          const SizedBox(width: 4),
                          if (index == 1 || index == 3)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              child: Text(
                                ':',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),

          const Spacer(),

          /// Bottom: Big Boxes + Draw Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Big boxes showing single digits
              Row(
                children: List.generate(_bigNumbers.length, (index) {
                  return Row(
                    children: [
                      BigBox(value: _bigNumbers[index].toString()),
                      if (index != _bigNumbers.length - 1)
                        const SizedBox(width: 6),
                    ],
                  );
                }),
              ),

              // Draw Time label
              Text(
                widget.drawTime,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Small box for single digit
class SmallBox extends StatelessWidget {
  final String value;
  const SmallBox({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 32,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: const Color(0xFF313038),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// Big box for single digit
class BigBox extends StatelessWidget {
  final String value;
  const BigBox({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 35,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: const Color(0xFF313038),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
