import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/models/customer_model.dart';
import 'package:space_solar_dealer/src/common/widgets/common_app_bar.dart';
import 'package:space_solar_dealer/src/customer_detail/view/widgets/panel_Id_Item.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final CustomerModel customer;

  const CustomerDetailsScreen({
    super.key,
    required this.customer,
  });

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {

  @override
  void initState() {
    super.initState();
    // Logic to run when the screen first loads
    print("Screen loaded for: ${widget.customer.name}");
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    double s(double v) => v * scale;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,

      appBar: CommonAppBar(
        scale: scale,
        showBack: true,
        onBackTap: () {
          context.pop();
        },
      ),

      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: s(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: s(24)),
                      Text(
                        'Customer Detail',
                        style: GoogleFonts.poppins(
                          color: ColorPalette.bottomtext,
                          fontSize: s(20),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: s(22)),
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: s(100),
                              height: s(100),
                              decoration: BoxDecoration(
                                color: ColorPalette.whitetext.withOpacity(0.50),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorPalette.whitetext,
                                  width: s(1),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                widget.customer.name.isNotEmpty
                                    ? widget.customer.name[0].toUpperCase()
                                    : 'B',
                                style: GoogleFonts.lato(
                                  fontSize: s(48),
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF000000),
                                ),
                              ),
                            ),

                            SizedBox(height: s(11)),

                            Text(
                              widget.customer.name,
                              style: GoogleFonts.lato(
                                fontSize: s(16),
                                fontWeight: FontWeight.w600,
                                color: ColorPalette.bottomtext,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: s(30)),

                      /// FIELDS
                    //  _buildField("Panel ID", "SS-001 to SS-024", scale),
                      _buildField("Phone Number", "9876543212", scale),
                      _buildField("Email", "${widget.customer.name.toLowerCase()}123@gmail.com", scale),
                      _buildField(
                        "Address",
                        "21/22 Raja colony, Ganapathy, Coimbatore",
                        scale,
                        isAddress: true,
                      ),
                      SizedBox(height:s(40),),
                      Padding(
                        padding: EdgeInsets.only(right: s(2)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Panel ID's",
                              style: GoogleFonts.lato(
                                fontSize: s(16),
                                fontWeight: FontWeight.w600,
                                color: ColorPalette.bottomtext,
                              ),
                            ),
                            Text(
                              "Total panels (07)",
                              style: GoogleFonts.lato(
                                fontSize: s(14),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF4A4A4A),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: s(12)),
                      Container(
                        height: s(400), // Fixed height to enable scrolling inside
                        decoration: BoxDecoration(
                          color: ColorPalette.whitetext.withOpacity(0.50),
                          borderRadius: BorderRadius.circular(s(10)),
                          border: Border.all(color: ColorPalette.whitetext),
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: 7,
                          itemBuilder: (context, index) {
                            return PanelIdItem(
                              id: "SS-PNID-00${index + 1}",
                              scale: scale,
                              isLast: index == 6, // Prevents bottom border on last item
                            );
                          },
                        )
                      ),
                      SizedBox(height: s(40)),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Notification Badge (scaled fix)
  Widget _buildNotificationBadge(double scale) {
    double s(double v) => v * scale;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topRight,
      children: [
        SvgPicture.asset(
          "assets/images/home/notification.svg",
          height: s(24),
          width: s(24),
        ),
        Positioned(
          right: -s(6), // ✅ scaled
          top: -s(6),
          child: Container(
            padding: EdgeInsets.all(s(4)), // ✅ scaled
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Text(
              '16',
              style: TextStyle(
                fontSize: s(9), // ✅ scaled
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 🔹 FIELD (scaled fix)
  Widget _buildField(
      String title,
      String value,
      double scale, {
        bool isAddress = false,
      }) {
    double s(double v) => v * scale;

    return Padding(
      padding: EdgeInsets.only(bottom: s(16)), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
              fontSize: s(16),
              fontWeight: FontWeight.w600,
              color: ColorPalette.bottomtext,
            ),
          ),

          SizedBox(height: s(14)), 

          Container(
            width: double.infinity,
            height: isAddress ? null : s(50),
            constraints: isAddress
                ? BoxConstraints(minHeight: s(71))
                : null,
            padding: EdgeInsets.symmetric(
              horizontal: s(16),
              vertical: s(14),
            ),
            decoration: BoxDecoration(
              color: ColorPalette.whitetext.withOpacity(0.50),
              borderRadius: BorderRadius.circular(s(10)),
              border: Border.all(
                color: ColorPalette.whitetext,
                width: s(1),
              ),
            ),

            child: Align(
              alignment: isAddress ?Alignment.topLeft : Alignment.centerLeft,
              child: Text(
                value,
                style: GoogleFonts.lato(
                  fontSize: s(16),
                  fontWeight: FontWeight.w400,
                  color: ColorPalette.textfiledin.withValues(alpha: .80),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}