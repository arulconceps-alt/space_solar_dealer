import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/common/widgets/global_navigator.dart';
import 'package:space_solar_dealer/src/notifications/data/in_app_notification.dart';

void showInAppNotification({
  required String title,
  required String body,
  String? imageUrl,
}) {

  final overlayContext =
      navigatorKey.currentState?.overlay?.context;

  if (overlayContext == null) {
    debugPrint("OVERLAY CONTEXT NULL");
    return;
  }

  showDialog(
    context: overlayContext,

    barrierDismissible: true,

    builder: (_) {
      return InAppNotificationBox(
        title: title,
        body: body,
        imageUrl: imageUrl,
      );
    },
  );
}