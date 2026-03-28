import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double scale;
  final bool showBack;
  final VoidCallback? onBackTap;

  const CommonAppBar({
    super.key,
    required this.scale,
    this.showBack = false,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: s(74),
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: showBack
          ? IconButton(
        onPressed: onBackTap ?? () => context.pop(),
        icon: Image.asset(
          'assets/images/new_register/back_arrow.png',
          width: s(20),
          height: s(20),
        ),
      )
          : null,

      title: Padding(
            padding: EdgeInsets.all(s(20)),
            child: SizedBox(
              width: s(192.75),
              height: s(20.56),
              child: SvgPicture.asset(
                "assets/images/login/logo.svg",
                fit: BoxFit.contain,
              ),
            ),
          ),

      bottom: PreferredSize(
        preferredSize: Size.fromHeight(s(1)),
        child: Container(
          height: s(1),
          color: ColorPalette.background.withOpacity(0.2),
        ),
      ),

      actions: [
       Padding(
              padding: EdgeInsets.only(right: s(20)),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  GestureDetector(
                    onTap: () => context.push('/notification_screen'),
                    child: SvgPicture.asset(
                      "assets/images/home/notification.svg",
                      width: s(24),
                      height: s(24),
                    ),
                  ),

                  Positioned(
                    right: -1,
                    top: -2,
                    child: Container(
                      width: s(12),
                      height: s(12),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(s(2)),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEA1F27),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "16",
                        style: GoogleFonts.poppins(
                          fontSize: s(6),
                          fontWeight: FontWeight.w500,
                          height: 1,
                          letterSpacing: 0,
                          color: ColorPalette.whitetext,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }

  /// ✅ FIXED HEIGHT (MATCHES toolbarHeight)
  @override
  Size get preferredSize => Size.fromHeight(74 * scale);
}