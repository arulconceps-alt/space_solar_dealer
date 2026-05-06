import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

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
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(s(10)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: const Color(0xFFF6F6F6),
          value: selectedIssue,
          hint: Text(
            "Select Issue Type",
            style: GoogleFonts.lato(
              fontSize: s(16),
              fontWeight: FontWeight.w400,
               color: const Color(0xFF484848).withOpacity(0.80),
            ),
          ),

          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: s(24), 
            color: Colors.grey,
          ),

          items: issues.map((issue) {
            return DropdownMenuItem<String>(
              value: issue,
              child: Text(
                issue,
                style: GoogleFonts.lato(
                  color: const Color(0xCC484848),
                  fontSize: s(16),
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }).toList(),

          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedIssue = value;
              });

              widget.onSelected(value);
            }
          },
        ),
      ),
    );
  }
}
