import 'package:flutter/material.dart';

class IssueDropdownField extends StatefulWidget {
  final double scale;
  final Function(String) onSelected;

  const IssueDropdownField({
    super.key,
    required this.scale,
    required this.onSelected,
  });

  @override
  State<IssueDropdownField> createState() => _IssueDropdownFieldState();
}

class _IssueDropdownFieldState extends State<IssueDropdownField> {
  String? selectedIssue;

  final List<String> issues = [
    "Inverter Not Working",
    "Low Power Output",
    "Panel Damage / Crack",
    "Battery Not Charging",
  ];

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * widget.scale;

    return Container(
      height: s(50),
      padding: EdgeInsets.symmetric(horizontal: s(12)),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6), // Match design background
        borderRadius: BorderRadius.circular(s(10)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: const Color(0xFFF6F6F6),
          value: selectedIssue,
          hint: Text(
            "Select Issue Type",
            style: TextStyle(fontSize: s(16)),
          ),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),

          items: issues.map((issue) {
            return DropdownMenuItem<String>(
              value: issue,
              child: Text(
                issue,
                style: TextStyle(fontSize: s(14)),
              ),
            );
          }).toList(),

          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedIssue = value;
              });

              widget.onSelected(value); // 🔥 send to parent
            }
          },
        ),
      ),
    );
  }
}