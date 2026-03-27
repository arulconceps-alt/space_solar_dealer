import 'package:flutter/material.dart';
import 'notification_card.dart';

class NotificationList extends StatelessWidget {
  final double scale;

  const NotificationList({
    super.key,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NotificationCard(
          scale: scale,
          title: "New Ticket Assigned",
          desc: "TKT-005 has been assigned to you.\nLocation: Coimbatore",
          isNew: true,
        ),
        NotificationCard(
          scale: scale,
          title: "New Ticket Assigned",
          desc: "TKT-006 has been assigned to you.\nLocation: Coimbatore",
          isNew: true,
        ),
      
      ],
    );
  }
}