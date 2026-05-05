import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/common/widgets/common_app_bar.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';
import 'package:space_solar_dealer/src/notifications/view/widgets/notification_list.dart';
import 'package:space_solar_dealer/src/notifications/view/widgets/notification_title.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    setState(() => isLoading = true);

    await Future.delayed(const Duration(seconds: 2)); // 👈 replace with API

    setState(() => isLoading = false);
  }

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
          child: Stack(
            children: [
              /// ✅ MAIN UI
              Column(
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

              /// ✅ LOADER OVERLAY
              if (isLoading)
                Positioned.fill(
                  child: AbsorbPointer(
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
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