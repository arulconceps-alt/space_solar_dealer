import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TicketDetailsDialog extends StatelessWidget {
  const TicketDetailsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;
    double s(double v) => v * scale;

    return Center(
      child: Container(
        width: s(400),
        constraints: BoxConstraints(maxHeight: s(706)),
        padding: EdgeInsets.all(s(20)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(s(20)),
        ),

        child: SingleChildScrollView( // ✅ prevents overflow
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔹 HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ticket Details",
                    style: GoogleFonts.poppins(
                      fontSize: s(18),
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF282828),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      "assets/images/ticket/cross_icon.png",
                      width: s(20),
                      height: s(20),
                    ),
                  )
                ],
              ),

              SizedBox(height: s(28)),

              /// 🔹 TICKET ID
              Text(
                "TKT-001",
                style: GoogleFonts.lato(
                  fontSize: s(16),
                  color: const Color(0xFF282828),
                ),
              ),

              SizedBox(height: s(20)),

              /// 🔹 CUSTOMER CARD
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(s(16)),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(s(10)),
                ),
                child: Column(
                  children: [
                    _infoRow(
                      "assets/images/ticket/noun_profile_icon.png",
                      "Customer Name",
                      "Rohit Sharma",
                      scale,
                    ),
                    _infoRow(
                      "assets/images/ticket/solar_panel.png",
                      "Panel ID",
                      "SS-2025-001",
                      scale,
                    ),
                    _infoRow(
                      "assets/images/ticket/exclamation_icon.png",
                      "Issue Type",
                      "Low Power Output",
                      scale,
                    ),
                    _infoRow(
                      "assets/images/ticket/calender_icon.png",
                      "Created Date",
                      "2025-11-14",
                      scale,
                    ),
                  ],
                ),
              ),

              SizedBox(height: s(20)),

              /// 🔹 TECHNICIAN
              Text(
                "Technician Assigned",
                style: GoogleFonts.lato(
                  fontSize: s(16),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF282828),
                ),
              ),

              SizedBox(height: s(10)),

              Container(
                padding: EdgeInsets.all(s(12)),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(s(10)),
                ),
                child: Row(
                  children: [
                    /// ICON
                    Image.asset(
                      "assets/images/ticket/gg_profile.png",
                      width: s(24),
                      height: s(24),
                    ),

                    SizedBox(width: s(10)),

                    /// NAME + DATE
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sharma",
                            style: GoogleFonts.lato(
                              fontSize: s(14),
                              color: const Color(0xFF282828),
                            ),
                          ),
                          Text(
                            "2025-11-14",
                            style: GoogleFonts.lato(
                              fontSize: s(12),
                              color: const Color(0xFF484848),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// CALL BUTTON
                    Container(
                      width: s(98),
                      height: s(40),
                      decoration: BoxDecoration(
                        color: const Color(0xFF26A7DF),
                        borderRadius: BorderRadius.circular(s(6)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Call",
                        style: GoogleFonts.poppins(
                          fontSize: s(16),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: s(20)),

              /// 🔹 DESCRIPTION
              Text(
                "Description",
                style: GoogleFonts.lato(
                  fontSize: s(16),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF282828),
                ),
              ),

              SizedBox(height: s(10)),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(s(12)),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(s(10)),
                ),
                child: Text(
                  "Panel showing reduced efficiency after recent dust storm.",
                  style: GoogleFonts.lato(
                    fontSize: s(16),
                    color: const Color(0xFF484848),
                  ),
                ),
              ),

              SizedBox(height: s(30)),

              /// 🔹 BUTTON
              Container(
                width: double.infinity,
                height: s(50),
                decoration: BoxDecoration(
                  color: const Color(0xFF26A7DF),
                  borderRadius: BorderRadius.circular(s(10)),
                ),
                alignment: Alignment.center,
                child: Text(
                  "View Whatsapp update",
                  style: GoogleFonts.poppins(
                    fontSize: s(16),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 reusable row
  Widget _infoRow(
      String icon,   // ✅ add icon path
      String title,
      String value,
      double scale,
      ) {
    double s(double v) => v * scale;

    return Padding(
      padding: EdgeInsets.only(bottom: s(14)),
      child: Row(
        children: [
          /// ✅ IMAGE (fixed)
          Image.asset(
            icon,
            width: s(24),
            height: s(24),
            fit: BoxFit.contain,

            /// 🔥 debug (optional)
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error, size: s(24), color: Colors.red);
            },
          ),

          SizedBox(width: s(12)),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lato(
                    fontSize: s(12),
                    color: const Color(0xFF484848),
                  ),
                ),
                SizedBox(height: s(2)),
                Text(
                  value,
                  style: GoogleFonts.lato(
                    fontSize: s(14),
                    color: const Color(0xFF282828),
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