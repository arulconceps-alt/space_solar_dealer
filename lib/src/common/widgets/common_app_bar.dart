import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/login/widgets/logo_widget.dart';

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

      /// 🔙 BACK BUTTON
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

      /// 🧩 LOGO
      title: LogoWidget(scale: scale),

      /// 🔻 BORDER
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(s(1)),
        child: Container(
          height: s(1),
          color: ColorPalette.background.withOpacity(0.2),
        ),
      ),

      /// 🔔 NOTIFICATION
      actions: [
        Padding(
          padding: EdgeInsets.only(right: s(20)),
          child: GestureDetector(
            onTap: () {
              context.push('/notification_screen');
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(
                  "assets/images/home/notification.svg",
                  height: s(20),
                  width: s(20),
                ),
                Transform.translate(
                  offset: Offset(s(8), -s(6)),
                  child: Container(
                    padding: EdgeInsets.all(s(3)),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '16',
                      style: TextStyle(
                        fontSize: s(9),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// ✅ FIXED HEIGHT (MATCHES toolbarHeight)
  @override
  Size get preferredSize => Size.fromHeight(74 * scale);
}