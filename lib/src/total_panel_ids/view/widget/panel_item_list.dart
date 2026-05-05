import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/total_panel_ids/view/widget/panel_details_dialog.dart';

class PanelItemList extends StatelessWidget {
  final dynamic panel;
  final String name;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onTap;

  const PanelItemList({
    super.key,
    required this.panel,
    required this.name,
    required this.onTap,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    // Use your Figma design width (usually 440 or 428) as the base
    final scale = w / 440;
    double s(double v) => v * scale;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: isFirst ? Radius.circular(s(10)) : Radius.zero,
          topRight: isFirst ? Radius.circular(s(10)) : Radius.zero,
          bottomLeft: isLast ? Radius.circular(s(10)) : Radius.zero,
          bottomRight: isLast ? Radius.circular(s(10)) : Radius.zero,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: s(5), sigmaY: s(5)),
          child: Container(
            // MATCH FIGMA: Height 70px
            height: s(70),
            // width: double.infinity is better than 400 because
            // the horizontal padding of 20px on a 440px screen
            // naturally creates a 400px card.
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: s(24)), // Space for icon/text
            decoration: BoxDecoration(
              color: ColorPalette.whitetext.withOpacity(0.50),
              border: Border.all(
                color: ColorPalette.whitetext,
                width: s(1), // MATCH FIGMA: Border 1px
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: GoogleFonts.lato(
                      fontSize: s(16),
                      fontWeight: FontWeight.w400,
                      color: ColorPalette.bottomtext,
                    ),
                  ),
                ),
                // MATCH FIGMA: Spacing/Size for Eye Icon
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => PanelDetailsDialog(
                          panel: panel,
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(s(6)),
                    child: Padding(
                      padding: EdgeInsets.all(s(4)),
                      child: Image.asset(
                        "assets/images/customer/eye_icon.png",
                        width: s(24),
                        height: s(24),
                        color: ColorPalette.bottomtext.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}