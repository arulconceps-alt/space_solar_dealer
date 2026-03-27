import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class ProfileInfoRow extends StatelessWidget {
  final String iconPath;
  final String? text;
  final Widget? child;
  final Color? iconColor;
  final double iconSize;
  final double Function(double) s;

  const ProfileInfoRow({
    super.key,
    required this.iconPath,
    required this.s,
    this.text,
    this.child,
    this.iconSize = 18,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          width: s(iconSize),
          height: s(iconSize),
          colorFilter: ColorFilter.mode(
            iconColor ?? ColorPalette.textfiledin.withValues(alpha: .60),
            BlendMode.srcIn,
          ),
        ),
        SizedBox(width: s(10)),
        Expanded(
          child: child ??
              Text(
                text ?? '',
                style: GoogleFonts.lato(
                  fontSize: s(14),
                  fontWeight: FontWeight.w400,
                  height: s(1),
                  color: ColorPalette.textfiledin.withValues(alpha: .80),
                ),
              ),
        ),
      ],
    );
  }
}