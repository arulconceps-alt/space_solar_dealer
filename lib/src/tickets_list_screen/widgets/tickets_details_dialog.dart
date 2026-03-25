
import 'package:flutter/material.dart';
import 'package:space_solar_dealer/src/common/widgets/app_text_styles.dart';


class TicketDetailsDialog extends StatelessWidget {
  const TicketDetailsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).size.width / 440;

    return Center(
      child: Container(
        width: 400 * scale,
        padding: EdgeInsets.all(20 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20 * scale),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ticket Details",
                  style: TextStyle(
                    fontSize: 18 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(
                    "assets/images/ticket/cross_icon.png",
                    width: 12,
                    height: 12,
                  ),
                )
              ],
            ),
            /// 🔹 Header

            SizedBox(height: 21 * scale),
            Text(
              "TKT-001",
              style: TextStyle(
                fontSize: 14 * scale,
                color: const Color(0xFF282828),
              ),
            ),

            SizedBox(height: 16 * scale),

            /// 🔹 Customer Card
            Container(
              padding: EdgeInsets.all(14 * scale),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(10 * scale),
              ),
              child: Column(
                children: [
                  _iconTextItem(
                    "assets/images/ticket/noun_profile_icon.png",
                    "Customer Name",
                    "Rohit Sharma",
                    scale,
                  ),
                  _iconTextItem(
                    "assets/images/ticket/solar_panel.png",
                    "Panel ID",
                    "SS-2025-001",
                    scale,
                  ),
                  _iconTextItem(
                    "assets/images/ticket/exclamation_icon.png",
                    "Issue Type",
                    "Low Power Output",
                    scale,
                  ),
                  _iconTextItem(
                    "assets/images/ticket/calender_icon.png",
                    "Created Date",
                    "2025-11-14",
                    scale,
                  ),
                ],
              ),
            ),

            SizedBox(height: 16 * scale),

            /// 🔹 Technician
            Text(
              "Technician Assigned",
              style: TextStyle(
                fontSize: 16 * scale,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 8 * scale),
            Container(
              padding: EdgeInsets.all(12 * scale),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(10 * scale),
              ),
              child: Row(
                children: [
                  /// 👤 Profile image
                  Image.asset(
                    "assets/images/ticket/gg_profile.png",
                    width: 24 * scale,
                    height: 24 * scale,
                  ),
                  SizedBox(width: 10 * scale),

                  /// Name + date
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sharma",
                          style: TextStyle(
                            fontSize: 14 * scale,
                            color: const Color(0xFF282828),
                          ),
                        ),
                        Text(
                          "2025-11-14",
                          style: TextStyle(
                            fontSize: 12 * scale,
                            color: const Color(0xFF484848),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Call button
                  Container(
                    width: 98.98 * scale,   // ✅ exact width
                    height: 40 * scale,     // ✅ exact height
                    decoration: BoxDecoration(
                      color: const Color(0xFF26A7DF),
                      borderRadius: BorderRadius.circular(6 * scale),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Call",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16 * scale, // ✅ match figma
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16 * scale),

            /// 🔹 Description
            Text(
              "Description",
              style: AppTextStyles.title,
            ),

            SizedBox(height: 8 * scale),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12 * scale),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Panel showing reduced efficiency after recent dust storm.",
                style: AppTextStyles.descriptionScaled(scale),
              ),
            ),

            SizedBox(height: 20 * scale),

            /// 🔹 Bottom Button
            Container(
              width: double.infinity,
              height: 50 * scale,
              decoration: BoxDecoration(
                color: const Color(0xFF26A7DF),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                "View WhatsApp Update",
                  style: AppTextStyles.buttonScaled(scale),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔥 Figma style row (ICON + TEXT)
  Widget _iconTextItem(
      String icon,
      String title,
      String value,
      double scale,
      ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16 * scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // ✅ FIX
        children: [
          Image.asset(
            icon,
            width: 24 * scale,
            height: 24 * scale,
          ),

          SizedBox(width: 12 * scale),

          Expanded( // ✅ important for proper alignment
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // ✅ center both texts
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12 * scale,
                    color: const Color(0xFF484848),
                    fontFamily: 'Lato',
                  ),
                ),
                SizedBox(height: 2 * scale),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14 * scale,
                    color: const Color(0xFF282828),
                    fontFamily: 'Lato',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}