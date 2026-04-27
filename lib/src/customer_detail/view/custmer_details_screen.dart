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
  List<String> panels = [];

  @override
  void initState() {
    super.initState();
    print("Screen loaded for: ${widget.customer.name}");
    _loadPanels();
  }

  void _loadPanels() {
    final List<String> temp = [];

    for (var order in widget.customer.orders) {
      for (var item in order.items) {
        if (item.serialNumber != null && item.serialNumber!.isNotEmpty) {
          temp.add(item.serialNumber!);
        }
      }
    }

    setState(() {
      panels = temp;
    });
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
        onBackTap: () => context.pop(),
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
                                ),
                              ),
                            ),

                            SizedBox(height: s(11)),

                            Text(
                              widget.customer.name,
                              style: GoogleFonts.lato(
                                fontSize: s(16),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: s(30)),

                      _buildField("Phone Number", widget.customer.phone, scale),

                      _buildField(
                        "Email",
                        widget.customer.email ?? "-",
                        scale,
                      ),

                      _buildField(
                        "Address",
                        widget.customer.addressLine1,
                        scale,
                        isAddress: true,
                      ),

                      SizedBox(height: s(40)),

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
                              ),
                            ),
                            Text(
                              "Total panels (${panels.length})",
                              style: GoogleFonts.lato(
                                fontSize: s(14),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: s(12)),

                      Column(
                        children: List.generate(panels.length, (index) {
                          return PanelIdItem(
                            id: panels[index],
                            scale: scale,
                            isLast: index == panels.length - 1,
                          );
                        }),
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
            ),
          ),
          SizedBox(height: s(14)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(s(14)),
            decoration: BoxDecoration(
              color: ColorPalette.whitetext.withOpacity(0.50),
              borderRadius: BorderRadius.circular(s(10)),
              border: Border.all(color: ColorPalette.whitetext),
            ),
            child: Text(value),
          ),
        ],
      ),
    );
  }
}