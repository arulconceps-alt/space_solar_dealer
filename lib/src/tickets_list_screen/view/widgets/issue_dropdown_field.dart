import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class IssueDropdownField extends StatefulWidget {
  final double scale; 
  final Function(String) onSelected;
  final String hint;

  const IssueDropdownField({
    super.key,
    required this.scale,
    required this.onSelected,
    this.hint = "Select Issue Type",
  });

  @override
  State<IssueDropdownField> createState() => _IssueDropdownFieldState();
}

class _IssueDropdownFieldState extends State<IssueDropdownField> {
  String? selectedValue;
  bool _showDropdown = false;

  final List<String> issues = const [
    "Inverter Not Working",
    "Low Power Output",
    "Panel Damage / Crack",
    "Battery Not Charging",
  ];

  @override
  Widget build(BuildContext context) {
     double s(double v) => v * widget.scale;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// FIELD
        GestureDetector(
          onTap: () {
            setState(() {
              _showDropdown = !_showDropdown;
            });
          },
          child: Container(
            height: s(52),
            padding: EdgeInsets.symmetric(horizontal: s(16)),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(s(10)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedValue ?? widget.hint,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.lato(
                      fontSize: s(16),
                      fontWeight: FontWeight.w400,
                     color: ColorPalette.textfiledin.withOpacity(0.80),
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: const Color(0xFF6D6D6D),
                  size: s(20),
                )
              ],
            ),
          ),
        ),

        /// DROPDOWN LIST (CUSTOM UI LIKE YOUR SECOND CODE)
        if (_showDropdown) ...[
          SizedBox(height: s(8)),

          Container(
            constraints: BoxConstraints(maxHeight: s(220)),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.96),
              borderRadius: BorderRadius.circular(s(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: s(10),
                  offset: Offset(0, s(4)),
                )
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: issues.length,
              itemBuilder: (context, index) {
                final item = issues[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedValue = item;
                      _showDropdown = false;
                    });

                    widget.onSelected(item);
                  },
                  child: Container(
                    height: s(50),
                    margin: EdgeInsets.symmetric(
                      horizontal: s(10),
                      vertical: s(6),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: s(16),
                      vertical: s(12),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(s(14)),
                    ),
                    child: Text(
                      item,
                      style: GoogleFonts.lato(
                        fontSize: s(16),
                        fontWeight: FontWeight.w400,
                     color: ColorPalette.textfiledin.withOpacity(0.80),
                    ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}