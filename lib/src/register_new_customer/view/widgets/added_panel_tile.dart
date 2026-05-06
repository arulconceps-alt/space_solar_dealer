import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddedPanelTile extends StatelessWidget {
  final String id;
  final double scale;
  final VoidCallback? onRemove;
  final bool showRemove; 

  const AddedPanelTile({
    super.key,
    required this.id,
    required this.scale,
    this.onRemove,
    this.showRemove = true,
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return Container(
      height: s(50),
      padding: EdgeInsets.symmetric(horizontal: s(16)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.50),
        borderRadius: BorderRadius.circular(s(10)),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            id,
            style: GoogleFonts.lato(
              fontSize: s(16),
              fontWeight: FontWeight.w400,
              color: const Color(0xFF484848).withOpacity(0.80),
            ),
          ),
          if (showRemove)
            GestureDetector(
              onTap: onRemove,
              child: Icon(
                Icons.close,
                size: s(20),
                color: Colors.black.withOpacity(0.50),
              ),
            ),
        ],
      ),
    );
  }
}