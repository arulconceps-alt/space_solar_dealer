import 'dart:math';
import 'package:flutter/material.dart';

class LotteryNumberCard extends StatefulWidget {
  final List<String> letters;
  final String prize;
  final String ticketPrice;
  final String gameType;

  // FIX: Change this line to match 4 parameters
  final Function(String letter, String value, int count, double pricePerUnit)
  onAdd;

  const LotteryNumberCard({
    super.key,
    this.letters = const ["A", "B", "C"],
    this.prize = "Win ₹1000",
    this.ticketPrice = "₹10",
    this.gameType = "Single Digit",
    required this.onAdd, // The bridge to the footer
  });

  @override
  State<LotteryNumberCard> createState() => _LotteryNumberCardState();
}

class _LotteryNumberCardState extends State<LotteryNumberCard> {
  late List<String> dashValues;
  late List<int> quantities;
  bool isQuickGuessClicked = false;

  @override
  void initState() {
    super.initState();
    dashValues = List.generate(widget.letters.length, (_) => "-");
    quantities = List.generate(widget.letters.length, (_) => 1);
  }

  void fillRandomDashes() {
    final random = Random();
    setState(() {
      isQuickGuessClicked = true;
      for (int i = 0; i < dashValues.length; i++) {
        dashValues[i] = random.nextInt(10).toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF24232A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.gameType,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(width: 8),
              Text(
                widget.prize,
                style: const TextStyle(color: Color(0xFFCFB95D), fontSize: 12),
              ),
              const Spacer(),
              _quickGuessButton(),
            ],
          ),
          Text(
            widget.ticketPrice,
            style: const TextStyle(color: Color(0xFF9F9F9F), fontSize: 12),
          ),
          const SizedBox(height: 16),
          ...List.generate(widget.letters.length, (index) => _buildRow(index)),
        ],
      ),
    );
  }

  Widget _buildRow(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          _letterBox(widget.letters[index]),
          const SizedBox(width: 10),
          _letterBox(dashValues[index]),
          const Spacer(),
          if (isQuickGuessClicked) ...[
            _quantitySelector(index),
            const SizedBox(width: 8),
            _goldAddButton(index),
          ] else ...[
            _greyAddButton(),
          ],
        ],
      ),
    );
  }

  Widget _goldAddButton(int index) {
    return GestureDetector(
      onTap: () {
        if (dashValues[index] == "-")
          return; // Prevent adding if no number selected

        double price =
            double.tryParse(widget.ticketPrice.replaceAll('₹', '')) ?? 0.0;

        // Pass specific details back to the Screen
        widget.onAdd(
          widget.letters[index],
          dashValues[index],
          quantities[index],
          price,
        );
      },
      child: Container(
        width: 44,
        height: 36,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: const Text(
          "Add",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _letterBox(String text) => Container(
    width: 36,
    height: 36,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: const Color(0xFF313038),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(text, style: const TextStyle(color: Colors.white)),
  );

  Widget _quickGuessButton() => GestureDetector(
    onTap: fillRandomDashes,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF313038),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        'Quick Guess',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    ),
  );

  Widget _greyAddButton() => Container(
    height: 36,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: const Color(0xFF313038),
      borderRadius: BorderRadius.circular(6),
    ),
    child: const Text("Add", style: TextStyle(color: Colors.white)),
  );

  Widget _quantitySelector(int index) => Container(
    width: 92,
    height: 36,
    decoration: BoxDecoration(
      color: const Color(0xFF313038),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () =>
              setState(() => quantities[index] = max(1, quantities[index] - 1)),
          child: const Text(
            "-",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        Text(
          "${quantities[index]}",
          style: const TextStyle(color: Colors.white),
        ),
        GestureDetector(
          onTap: () => setState(() => quantities[index]++),
          child: const Text(
            "+",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    ),
  );
}
