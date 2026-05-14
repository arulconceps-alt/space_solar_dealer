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

      padding: EdgeInsets.symmetric(horizontal: s(16)),

      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedIssue,

          isExpanded: true,

          menuMaxHeight: s(300),

          dropdownColor: Colors.white,

          borderRadius: BorderRadius.circular(s(20)),

          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: const Color(0xFF6D6D6D),
            size: s(22),
          ),

          hint: Text(
            "Select Issue Type",
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.lato(
              fontSize: s(16),
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6D6D6D),
            ),
          ),

          style: GoogleFonts.lato(
            fontSize: s(16),
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6D6D6D),
          ),

          items: issues.map((issue) {
            return DropdownMenuItem<String>(
              value: issue,

              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: s(6),
                  vertical: s(4),
                ),

                child: Text(
                  issue,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: GoogleFonts.lato(
                    fontSize: s(16),
                    fontWeight: FontWeight.w400,
                    color:
                        ColorPalette.textfiledin.withValues(alpha: .80),
                  ),
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