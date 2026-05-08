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
      height: s(52),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(s(10)),
      ),
      padding: EdgeInsets.symmetric(horizontal: s(14)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedIssue,
          isExpanded: true,

          /// Dropdown below field
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(s(12)),

          hint: Text(
            "Select Issue Type",
            style: GoogleFonts.lato(
              fontSize: s(15),
              fontWeight: FontWeight.w400,
              color: const Color(0xFF484848).withOpacity(0.80),
            ),
          ),

          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.grey,
            size: s(24),
          ),

          style: GoogleFonts.lato(
            fontSize: s(15),
            color: ColorPalette.bottomtext,
            fontWeight: FontWeight.w500,
          ),

          items: issues.map((issue) {
            return DropdownMenuItem<String>(
              value: issue,
              child: Text(
                issue,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.lato(
                  fontSize: s(15),
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF484848).withOpacity(0.80),
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
