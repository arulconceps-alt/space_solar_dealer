
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  final double scale;
  const LogoutButton({super.key,required this.scale});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: 40 * scale,
        padding: EdgeInsets.symmetric(horizontal: 16 * scale),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10 * scale),
          border: Border.all(color: Colors.white),
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/images/profile/logout.png",
              width: 20 * scale,
              height: 20 * scale,
            ),
            SizedBox(width: 8 * scale),
            Text(
              "Logout",
              style: TextStyle(
                fontSize: 16 * scale,
                fontWeight: FontWeight.w600,
                color: const Color(0xCC484848),
              ),
            ),
          ],
        ),
      ),
    );
  }
}