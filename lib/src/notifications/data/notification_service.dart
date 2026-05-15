import 'package:hive/hive.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance =
      NotificationService._();

  static const String boxName =
      "notifications_box";

  static const String notificationKey =
      "notifications";

  late Box box;

  Future<void> init() async {
    box = await Hive.openBox(boxName);
  }

  List<Map<String, dynamic>>
      getNotifications() {

    final data = box.get(
      notificationKey,
      defaultValue: [],
    );

    return List<Map<String, dynamic>>.from(
      (data as List).map(
        (e) => Map<String, dynamic>.from(e),
      ),
    );
  }

  int getUnreadCount() {

    final notifications =
        getNotifications();

    return notifications
        .where(
          (e) => e['isRead'] == false,
        )
        .length;
  }

  Future<void> addNotification({
    required String title,
    required String body,
    String? imageUrl,
  }) async {

    final current =
        getNotifications();

    current.insert(
      0,
      {
        "title": title,
        "body": body,
        "imageUrl": imageUrl,
        "isRead": false,
        "time":
            DateTime.now()
                .toIso8601String(),
      },
    );

    await box.put(
      notificationKey,
      current,
    );
  }

  Future<void> markAllAsRead() async {

    final current =
        getNotifications();

    final updated =
        current.map((item) {

      return {
        ...item,
        "isRead": true,
      };

    }).toList();

    await box.put(
      notificationKey,
      updated,
    );
  }

  Future<void> clearNotifications() async {

    await box.put(
      notificationKey,
      [],
    );
  }
}