import 'dart:math';
import 'package:flutter/material.dart';

class LotteryNumberCardDouble extends StatefulWidget {
  final String lotteryType;
  final String prize;
  final String ticketPrice;
  final List<List<String>> rows;
  final Function(String letter, String value, int count, double pricePerUnit)
  onAdd;

  const LotteryNumberCardDouble({
    super.key,
    required this.lotteryType,
    required this.prize,
    required this.ticketPrice,
    required this.rows,
    required this.onAdd,
  });

  @override
  State<LotteryNumberCardDouble> createState() =>
      _LotteryNumberCardDoubleState();
}

class _LotteryNumberCardDoubleState extends State<LotteryNumberCardDouble> {
  late List<List<String>> dashValues;
  late List<int> quantities;
  bool isQuickGuessClicked = false;

  @override
  void initState() {
    super.initState();
    dashValues = List.generate(widget.rows.length, (_) => ["-", "-"]);
    quantities = List.generate(widget.rows.length, (_) => 1);
  }

  Widget _box(String text, {Color? color}) {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: color ?? const Color(0xFF313038),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _goldAddButton(int rowIndex) {
    return GestureDetector(
      onTap: () {
        // 1. Clean price string to get unit price (e.g. "₹100" -> 100.0)
        double unitPrice =
            double.tryParse(
              widget.ticketPrice.replaceAll(RegExp(r'[^0-9.]'), ''),
            ) ??
            0.0;

        // 2. Prepare the combined Label (e.g., "AB") and Value (e.g., "57")
        String combinedLetters = widget.rows[rowIndex].join("");
        String combinedValues = dashValues[rowIndex].join("");

        if (combinedValues.contains("-"))
          return; // Don't add if digits aren't picked

        // 3. FIX: Pass all 4 required arguments to the callback
        widget.onAdd(
          combinedLetters, // letter
          combinedValues, // value
          quantities[rowIndex], // count
          unitPrice, // pricePerUnit
        );
      },
      child: Container(
        width: 44,
        height: 36,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(1.00, 0.50),
            end: Alignment(0.00, 0.50),
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

  Widget _quantitySelector(int index) {
    return Container(
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
            onTap: () => setState(
              () => quantities[index] = max(1, quantities[index] - 1),
            ),
            child: const Text(
              "-",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Text(
            "${quantities[index]}",
            style: const TextStyle(color: Colors.white, fontSize: 14),
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

  Widget buildRow(int rowIndex, List<String> letters) {
    return Row(
      children: [
        for (var letter in letters) ...[
          _box(letter),
          const SizedBox(width: 10),
        ],
        _box(dashValues[rowIndex][0]),
        const SizedBox(width: 10),
        _box(dashValues[rowIndex][1]),
        const Spacer(),

        if (isQuickGuessClicked) ...[
          _quantitySelector(rowIndex),
          const SizedBox(width: 8),
          _goldAddButton(rowIndex),
        ] else ...[
          // Grey Add Button (Disabled state)
          Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFF313038),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text("Add", style: TextStyle(color: Colors.white)),
          ),
        ],
      ],
    );
  }

  void fillRandomDashes() {
    final random = Random();
    setState(() {
      isQuickGuessClicked = true;
      for (int i = 0; i < dashValues.length; i++) {
        dashValues[i][0] = random.nextInt(10).toString();
        dashValues[i][1] = random.nextInt(10).toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: const Color(0xFF24232A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.lotteryType,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(width: 8),
              Text(
                widget.prize,
                style: const TextStyle(color: Color(0xFFCFB95D), fontSize: 12),
              ),
              const Spacer(),
              GestureDetector(
                onTap: fillRandomDashes,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF313038),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Quick Guess',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            widget.ticketPrice,
            style: const TextStyle(color: Color(0xFF9F9F9F), fontSize: 12),
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < widget.rows.length; i++) ...[
            buildRow(i, widget.rows[i]),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}
