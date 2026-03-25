
import 'package:flutter/material.dart';

class NotificationCard extends StatefulWidget {
  final double scale;
  final String title;
  final String description;
  final bool isNew;

  const NotificationCard({
    super.key,
    required this.scale,
    required this.title,
    required this.description,
    this.isNew = true,
  });

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool isRead = false;

  @override
  Widget build(BuildContext context) {
    final scale = widget.scale;

    return GestureDetector(
      onTap: () {
        setState(() {
          isRead = true; // 👈 mark as read
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16 * scale),
        padding: EdgeInsets.all(16 * scale),
        decoration: BoxDecoration(
          color: isRead
              ? Colors.white.withOpacity(0.3) // 👈 change when read
              : Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔹 ICON
            Container(
              width: 50 * scale,
              height: 50 * scale,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center( // 👈 IMPORTANT
                child: Image.asset(
                  "assets/images/notification/notepad_icon.png",
                  width: 24 * scale,
                  height: 24 * scale,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            SizedBox(width: 12 * scale),

            /// 🔹 TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// TITLE + TAG
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            color: const Color(0xFF282828),
                            fontSize: 16 * scale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      /// 🔴 NEW TAG
                      if (widget.isNew && !isRead)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10 * scale,
                            vertical: 2 * scale,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0x4CEA1F27),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "New",
                            style: TextStyle(
                              color: const Color(0xFFEA1F27),
                              fontSize: 10 * scale,
                            ),
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: 6 * scale),

                  /// DESCRIPTION
                  Text(
                    widget.description,
                    style: TextStyle(
                      color: const Color(0xCC484848),
                      fontSize: 14 * scale,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
