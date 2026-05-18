import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/models/panel_model.dart';

class PanelDetailsDialog extends StatelessWidget {
  final dynamic panel; // Changed to dynamic

  const PanelDetailsDialog({
    super.key,
    required this.panel,
  });

  String _formatDate(DateTime? date) {
    if (date == null) return "-";
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year}";
  }

  String _getCustomerName() {
    if (panel is TotalPanelListPanelModel) {
      return panel.customerName;
    } else if (panel is PanelModel) {
      return panel.customerName;
    }
    return "";
  }

  String _getSerialNumber() {
    if (panel is TotalPanelListPanelModel) {
      return panel.serialNumber;
    } else if (panel is PanelModel) {
      return panel.serialNumber;
    }
    return "";
  }

  String _getCustomerEmail() {
    if (panel is TotalPanelListPanelModel) {
      return panel.customerEmail;
    } else if (panel is PanelModel) {
      return panel.customerEmail;
    }
    return "";
  }

  String _getCustomerPhone() {
    if (panel is TotalPanelListPanelModel) {
      return panel.customerPhone;
    } else if (panel is PanelModel) {
      return panel.customerPhone;
    }
    return "";
  }

  DateTime? _getSoldAt() {
    if (panel is TotalPanelListPanelModel) {
      return panel.soldAt;
    } else if (panel is PanelModel) {
      return panel.soldAt;
    }
    return null;
  }

  String _getCustomerAddress() {
    if (panel is TotalPanelListPanelModel) {
      return panel.customerAddress;
    } else if (panel is PanelModel) {
      return panel.customerAddress;
    }
    return "";
  }

  String _getWarrantyText() {
    DateTime? physicalEndDate;
    DateTime? performanceEndDate;
    
    if (panel is TotalPanelListPanelModel) {
      physicalEndDate = panel.physicalWarrantyEndDate;
      performanceEndDate = panel.performanceWarrantyEndDate;
    } else if (panel is PanelModel) {
      physicalEndDate = panel.physicalWarrantyEndDate;
      performanceEndDate = panel.performanceWarrantyEndDate;
    }
    
    if (physicalEndDate != null && performanceEndDate != null) {
      final physicalYears = (physicalEndDate.difference(DateTime.now()).inDays ~/ 365).abs();
      final performanceYears = (performanceEndDate.difference(DateTime.now()).inDays ~/ 365).abs();
      return "Physical ${physicalYears} years, Performance ${performanceYears} years";
    }
    return "Physical 12 years, Performance 30 years";
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;
    double s(double v) => v * scale;

    return Center(
      child: Container(
        width: s(400),
        padding: EdgeInsets.all(s(20)),
        decoration: BoxDecoration(
          color: ColorPalette.whitetext,
          borderRadius: BorderRadius.circular(s(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Customer Details",
                  style: GoogleFonts.poppins(
                    fontSize: s(18),
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.bottomtext,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(
                    "assets/images/ticket/cross_icon.png",
                    width: s(12.73),
                    height: s(12.73),
                  ),
                )
              ],
            ),
            SizedBox(height: s(20)),
            Container(
              width: s(360),
              padding: EdgeInsets.symmetric(
                vertical: s(20),
                horizontal: s(16),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(s(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow(
                    "assets/images/ticket/noun_profile_icon.png",
                    "Customer Name",
                    _getCustomerName(),
                    scale,
                    24,
                    17,
                  ),
                  SizedBox(height: s(20)),
                  _infoRow(
                    "assets/images/ticket/solar_panel.png",
                    "Panel ID",
                    _getSerialNumber(),
                    scale,
                    28,
                    15,
                  ),
                  SizedBox(height: s(20)),
                  _infoRow(
                    "assets/images/customer/email_icon.png",
                    "Email",
                    _getCustomerEmail(),
                    scale,
                    22,
                    19,
                  ),
                  SizedBox(height: s(20)),
                  _infoRow(
                    "assets/images/customer/phone_icon.png",
                    "Phone Number",
                    _getCustomerPhone(),
                    scale,
                    22,
                    19,
                  ),
                  SizedBox(height: s(20)),
                  _infoRow(
                    "assets/images/ticket/calender_icon.png",
                    "Created Date",
                    _formatDate(_getSoldAt()),
                    scale,
                    24,
                    18,
                  ),
                  SizedBox(height: s(20)),
                  _infoRow(
                    "assets/images/ticket/warrenty.png",
                    "Warranty",
                    _getWarrantyText(),
                    scale,
                    24,
                    18,
                  ),
                ],
              ),
            ),
            SizedBox(height: s(16)),
            if (_getCustomerAddress().isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Address",
                      style: GoogleFonts.lato(
                        fontSize: s(14),
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.bottomtext,
                      ),
                    ),
                    SizedBox(height: s(10)),
                  Container(
                    height: s(70),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: s(10),
                      horizontal: s(16),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(s(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getCustomerAddress(),
                          style: GoogleFonts.lato(
                            fontSize: s(14),
                            fontWeight: FontWeight.w400,
                            color: ColorPalette.textfiledin,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            SizedBox(height: s(24)),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(
    String icon,
    String title,
    String value,
    double scale,
    double iconsize,
    double width,
  ) {
    double s(double v) => v * scale;

    return Row(
      children: [
        Image.asset(
          icon,
          width: s(iconsize),
          height: s(iconsize),
          color: ColorPalette.textfiledin.withOpacity(0.8),
        ),
        SizedBox(width: s(width)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.lato(
                  fontSize: s(14),
                  fontWeight: FontWeight.w400,
                  color: ColorPalette.textfiledin,
                ),
              ),
              SizedBox(height: s(4)),
              Text(
                value,
                style: GoogleFonts.lato(
                  fontSize: s(14),
                  fontWeight: FontWeight.w400,
                  color: ColorPalette.bottomtext,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}