import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/notifications/data/notification_store.dart';
import 'notification_card.dart';

class NotificationList extends StatelessWidget {
  final double scale;

  const NotificationList({
    super.key,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder<
        List<Map<String, dynamic>>>(
      valueListenable:
          NotificationStore
              .instance
              .notifications,

      builder: (
        context,
        notifications,
        _,
      ) {

        if (notifications.isEmpty) {
          return const Center(
            child: Text(
              "No Notifications",
            ),
          );
        }

        return Column(
          children:
              notifications.map((notification) {

            return NotificationCard(
              scale: scale,

              title:
                  notification["title"] ?? '',

              desc:
                  notification["body"] ?? '',

              isNew:
                  !(notification["isRead"] ?? false),
            );

          }).toList(),
        );
      },
    );
  }
}