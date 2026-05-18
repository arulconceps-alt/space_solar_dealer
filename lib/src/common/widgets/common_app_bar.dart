import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/notifications/data/notification_store.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double scale;
  final bool showBack;
  final bool showNotification;
  final VoidCallback? onBackTap;

  const CommonAppBar({
    super.key,
    required this.scale,
    this.showBack = false,
    this.showNotification = false,
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
              onPressed: () {
                if (onBackTap != null) {
                  onBackTap!();
                } else if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
              icon: Image.asset(
                'assets/images/new_register/back_arrow.png',
                width: s(20),
                height: s(20),
              ),
            )
          : null,

      title: Padding(
        padding: EdgeInsets.all(s(20)),
        child: Image.asset(
          "assets/images/login/KRG.png",
          width: s(55),
          height: s(50),
          fit: BoxFit.contain,
        ),
      ),

      bottom: PreferredSize(
        preferredSize: Size.fromHeight(s(1)),
        child: Container(
          height: s(1),
          color: ColorPalette.background.withOpacity(0.2),
        ),
      ),

      actions: showNotification
          ? [
              Padding(
                padding: EdgeInsets.only(right: s(20)),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    GestureDetector(
                      onTap: () => context.push('/notification_screen'),
                      child: SvgPicture.asset(
                        "assets/images/home/notification.svg",
                        width: s(26),
                        height: s(26),
                      ),
                    ),

                    ValueListenableBuilder<int>(
                      valueListenable: NotificationStore.instance.unreadCount,

                      builder: (context, unreadCount, _) {
                        if (unreadCount == 0) {
                          return const SizedBox.shrink();
                        }

                        return Positioned(
                          right: -1,
                          top: -2,
                          child: Container(
                            width: s(14),
                            height: s(14),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(s(2)),
                            decoration: const BoxDecoration(
                              color: Color(0xFFEA1F27),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              unreadCount > 99 ? "99+" : unreadCount.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: s(6),
                                fontWeight: FontWeight.w500,
                                height: 1,
                                color: ColorPalette.whitetext,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(74 * scale);
}
