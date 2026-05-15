import 'package:flutter/material.dart';
import 'notification_service.dart';

class NotificationStore {
  NotificationStore._();

  static final NotificationStore instance =
      NotificationStore._();

  final ValueNotifier<
      List<Map<String, dynamic>>>
      notifications =
      ValueNotifier([]);

  final ValueNotifier<int>
      unreadCount =
      ValueNotifier(0);

  Future<void> loadNotifications() async {

    final items =
        NotificationService.instance
            .getNotifications();

    notifications.value = items;

    unreadCount.value =
        items.where(
          (e) => e['isRead'] == false,
        ).length;
  }

  Future<void> addNotification({
    required String title,
    required String body,
    String? imageUrl,
  }) async {

    await NotificationService.instance
        .addNotification(
      title: title,
      body: body,
      imageUrl: imageUrl,
    );

    await loadNotifications();
  }

  Future<void> markAllAsRead() async {

    await NotificationService.instance
        .markAllAsRead();

    await loadNotifications();
  }

  Future<void> clearNotifications() async {

    await NotificationService.instance
        .clearNotifications();

    await loadNotifications();
  }
}