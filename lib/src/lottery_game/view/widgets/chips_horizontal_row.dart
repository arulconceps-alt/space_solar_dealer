import 'package:flutter/material.dart';

class ChipsHorizontalRow extends StatefulWidget {
  final List<String> times;
  final Function(String) onTimeSelected;

  const ChipsHorizontalRow({
    super.key,
    required this.times,
    required this.onTimeSelected,
  });

  @override
  State<ChipsHorizontalRow> createState() => _ChipsHorizontalRowState();
}

class _ChipsHorizontalRowState extends State<ChipsHorizontalRow> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onTimeSelected(widget.times[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFF1B1A1F),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.times.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final bool isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });

              widget.onTimeSelected(widget.times[index]);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                        colors: [Color(0xFFDFC45C), Color(0xFFA89A5F)],
                      )
                    : null,
                color: isSelected ? null : const Color(0xFF24232A),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.times[index],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'DM Sans',
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
