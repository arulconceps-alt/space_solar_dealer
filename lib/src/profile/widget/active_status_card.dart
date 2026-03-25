
import 'package:flutter/material.dart';

class ActiveStatusCard extends StatelessWidget {
  final double scale;
  const ActiveStatusCard({super.key,required this.scale});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5), // 👈 important
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Active Status",
                style: TextStyle(
                  fontSize: 18 * scale,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF282828),
                ),
              ),
              SizedBox(height: 4 * scale),
              Text(
                "Toggle your availability for works",
                style: TextStyle(
                  fontSize: 14 * scale,
                  color: const Color(0xCC484848),
                ),
              ),
            ],
          ),

          /// Switch
          Switch(
            value: true,
            onChanged: (v) {},
            activeColor: Colors.white, // thumb
            activeTrackColor: const Color(0xFF26A7DF), // blue
          ),
        ],
      ),
    );
  }
}