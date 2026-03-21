
import 'package:flutter/material.dart';

class ActivityTile extends StatelessWidget {
  final String title;
  final String name;
  final String status;
  final String time;
  final Color statusColor;

  const ActivityTile({
    super.key,
    required this.title,
    required this.name,
    required this.status,
    required this.time,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    bool isCompleted = status == "Completed";
    bool isPending = status == "Pending";
    bool isInProgress = status == "In-Progress";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.white.withValues(alpha: 0.50),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LEFT SIDE
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF282828),
                    fontSize: 16,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  name,
                  style: TextStyle(
                    color: const Color(0xCC484848),
                    fontSize: 14,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          /// RIGHT SIDE
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? const Color(0xFF484848)
                      : isPending
                      ? statusColor.withValues(alpha: 0.2)
                      : const Color(0x33484848), // ✅ In-progress bg
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: isCompleted
                        ? Colors.white
                        : isPending
                        ? statusColor
                        : const Color(0xFF282828),
                    fontSize: 10,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                time,
                style: TextStyle(
                  color: const Color(0xCC484848),
                  fontSize: 12,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}