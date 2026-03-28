import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/common/widgets/common_app_bar.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';
import 'package:space_solar_dealer/src/notifications/widgets/notification_list.dart';
import 'package:space_solar_dealer/src/notifications/widgets/notification_title.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    double s(double v) => v * scale;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,

      appBar: CommonAppBar(
        scale: scale,
        showBack: true,
        showNotification: false,
        onBackTap: () => context.pop(),
      ),

      body: AppBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: s(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: s(24)),

                      NotificationTitle(scale: scale),

                      SizedBox(height: s(20)),

                      NotificationList(scale: scale),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}