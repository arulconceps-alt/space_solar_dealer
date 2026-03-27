import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/widgets/common_app_bar.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';

class RegisterCustomerScreen extends StatelessWidget {
  const RegisterCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 440;

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
      /// 1. STANDARD APPBAR
      /*appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 74 * scale,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: SizedBox(
            width: 7.5 * scale,
            height: 15 * scale,
            child: Image.asset(
              'assets/images/new_register/back_arrow.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: SvgPicture.asset(
          "assets/images/login/logo.svg",
          height: 24 * scale,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20 * scale),
            child: _buildNotificationIcon(scale),
          )
        ],
      ),*/

      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20 * scale),

                /// TITLE
                Text(
                  'Register Customer & Panel IDs',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF282828),
                    fontSize: 20 * scale,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 20 * scale),

                /// 2. CUSTOMER DETAILS CARD
                _buildCardContainer(
                  scale: scale,
                  title: "Customer Details",
                  child: Column(
                    children: [
                      _buildInputField("Customer Name*", "Customer Name", scale),
                      _buildInputField("Phone Number*", "Phone Number", scale),
                      _buildInputField("Email*", "Email", scale),
                      _buildInputField("Address*", "Enter full installation address", scale, isAddress: true),
                    ],
                  ),
                ),

                SizedBox(height: 20 * scale),

                /// 3. REGISTER PANEL (DOTTED SCANNER) CARD
                _buildCardContainer(
                  scale: scale,
                  title: "Register Panel",
                  centerChild: true, // Centers the scanner
                  child: Column(
                    children: [
                      DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          color: ColorPalette.textfiledin,
                          strokeWidth: 2,
                          dashPattern: const [6, 4],
                          radius: Radius.circular(10 * scale),
                        ),
                        child: Container(
                          width: 180 * scale,
                          height: 180 * scale,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10 * scale),
                          ),
                          child: Center(
                            child: Image.asset(
                              "assets/images/new_register/qr_scan.png",
                              width: 90 * scale,
                              height: 90 * scale,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.qr_code_scanner, size: 80 * scale, color: const Color(0xFF484848)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15 * scale),
                      Text(
                        'Position QR code within the frame',
                        style: GoogleFonts.lato(fontSize: 14 * scale, color: const Color(0xCC484848)),
                      ),
                      SizedBox(height: 20 * scale),
                      _buildBlueButton("Scan", scale, () {}),
                    ],
                  ),
                ),

                SizedBox(height: 25 * scale),
                _buildOrDivider(scale),
                SizedBox(height: 25 * scale),

                /// 4. MANUAL ENTRY CARD
                _buildCardContainer(
                  scale: scale,
                  title: "Enter Panel ID Manual",
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildSimpleInput("Enter Panel ID", scale),
                      ),
                      SizedBox(width: 10 * scale),
                      _buildSmallAddButton(scale),
                    ],
                  ),
                ),

                /// 5. ADDED PANELS LIST
                SizedBox(height: 20 * scale),
                _buildAddedPanelTile("SS-78A00-S001", scale),
                _buildAddedPanelTile("SS-78A00-S002", scale),

                SizedBox(height: 30 * scale),

                /// 6. SUBMIT BUTTON
                _buildBlueButton("Submit", scale, () {}),

                SizedBox(height: 40 * scale),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// --- UI HELPER METHODS ---

  Widget _buildCardContainer({required double scale, required String title, required Widget child, bool centerChild = false}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: centerChild ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(title, style: GoogleFonts.poppins(fontSize: 18 * scale, fontWeight: FontWeight.w500)),
          ),
          SizedBox(height: 15 * scale),
          child,
        ],
      ),
    );
  }

  Widget _buildInputField(String label, String hint, double scale, {bool isAddress = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.lato(fontSize: 16 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 8 * scale),
          _buildSimpleInput(hint, scale, isAddress: isAddress),
        ],
      ),
    );
  }

  Widget _buildSimpleInput(String hint, double scale, {bool isAddress = false}) {
    return Container(
      height: isAddress ? null : 50 * scale,
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10 * scale),
        border: Border.all(color: Colors.white),
      ),
      child: TextField(
        maxLines: isAddress ? 3 : 1,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          hintStyle: GoogleFonts.lato(color: const Color(0xCC484848), fontSize: 16 * scale),
        ),
      ),
    );
  }

  Widget _buildBlueButton(String text, double scale, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFF26A7DF),
          borderRadius: BorderRadius.circular(10 * scale),
        ),
        alignment: Alignment.center,
        child: Text(text, style: GoogleFonts.poppins(color: Colors.white, fontSize: 16 * scale, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildSmallAddButton(double scale) {
    return Container(
      width: 100 * scale,
      height: 50 * scale,
      decoration: BoxDecoration(
        color: const Color(0xFF26A7DF),
        borderRadius: BorderRadius.circular(6 * scale),
      ),
      alignment: Alignment.center,
      child: Text("Add", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildAddedPanelTile(String id, double scale) {
    return Container(
      margin: EdgeInsets.only(bottom: 10 * scale),
      height: 50 * scale,
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD).withOpacity(0.7), // Slight blue tint like your old code
        borderRadius: BorderRadius.circular(10 * scale),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(id, style: GoogleFonts.lato(fontSize: 16 * scale, color: const Color(0xFF484848))),
          Icon(Icons.close, size: 20 * scale, color: const Color(0xFF484848)),
        ],
      ),
    );
  }

  Widget _buildOrDivider(double scale) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFF484848), thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10 * scale),
          child: Text("OR", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: const Color(0xFF484848))),
        ),
        const Expanded(child: Divider(color: Color(0xFF484848), thickness: 1)),
      ],
    );
  }

  Widget _buildNotificationIcon(double scale) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        SvgPicture.asset("assets/images/home/notification.svg", height: 24 * scale),
        Positioned(
          right: -2,
          top: -2,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
            child: const Text('16', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          ),
        )
      ],
    );
  }
}