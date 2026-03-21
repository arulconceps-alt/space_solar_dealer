import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart'; // Import this
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';
import 'package:space_solar_dealer/src/home/widgets/top_header_card.dart';
import 'package:space_solar_dealer/src/register_new_customer/widgets/register_blur_circle.dart';

class RegisterCustomerScreen extends StatefulWidget {
  const RegisterCustomerScreen({super.key});

  @override
  State<RegisterCustomerScreen> createState() => _RegisterCustomerScreenState();
}

class _RegisterCustomerScreenState extends State<RegisterCustomerScreen> {
  // Simulated list of added panels from your screenshot
  final List<String> _addedPanels = ["SS-78A00-S001", "SS-78A00-S002"];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;
    return Scaffold(
      backgroundColor: const Color(0xFFB5E2F4),
      body: Stack(
        children: [
          RegisterBlurCircle(
            left: -146,
            top: -201,
            size: 383,
            color: Colors.white,
            scale: scale,
            blur: 60,
          ),
          RegisterBlurCircle(
            left: 209,
            top: 94,
            size: 383,
            color: Colors.white.withOpacity(0.3),
            scale: scale,
            blur: 40,
          ),
          RegisterBlurCircle(
            left: -153,
            top: 575,
            size: 383,
            color: Colors.white.withOpacity(0.6),
            scale: scale,
            blur: 50,
          ),

          SafeArea(
            child: Column(
              children: [
                // 1. Header is now the first item in the list
                TopHeaderCard(
                  scale: scale,
                  notificationCount: "16",
                  onBackTap: () {
                    Navigator.pop(context);
                  },
                ),

                // 2. Form content follows
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 20 * scale,
                  vertical: 20 * scale,
                ),
                      children: [
                        Text(
                          'Register Customer & Panel IDs',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF282828),
                            fontSize: 20 * scale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20 * scale),

                        // Section 1: Customer Details
                        _buildSectionCard(
                          scale: scale,
                          title: "Customer Details",
                          child: Column(
                            children: [
                              _buildTextField("Customer Name*", "Customer Name", scale),
                              _buildTextField("Phone Number*", "Phone Number", scale),
                              _buildTextField("Email*", "Email", scale),
                              _buildTextField("Address*", "Enter full installation address", scale, isMultiline: true),
                            ],
                          ),
                        ),

                        SizedBox(height: 20 * scale),

                        // Section 2: Register Panel (QR)
                        _buildSectionCard(
                          scale: scale,
                          title: "Register Panel",
                          child: Column(
                            children: [
                              DottedBorder(
                                options: RoundedRectDottedBorderOptions(
                                  color: const Color(0xFF26A7DF),
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
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15 * scale),
                              Text(
                                "Position QR code within the frame",
                                style: GoogleFonts.lato(fontSize: 14 * scale, color: Colors.black54),
                              ),
                              SizedBox(height: 20 * scale),
                              _buildPrimaryButton("Scan", ColorPalette.background, scale),
                            ],
                          ),
                        ),

                        SizedBox(height: 20 * scale),
                        _buildDivider(scale),
                        SizedBox(height: 20 * scale),

                        // Section 3: Manual Entry
                        _buildSectionCard(
                          scale: scale,
                          title: "Enter Panel ID Manual",
                          child: Row(
                            children: [
                              Expanded(child: _buildSimpleInput("Enter Panel ID", scale)),
                              SizedBox(width: 10 * scale),
                              _buildSmallButton("Add", scale),
                            ],
                          ),
                        ),

                        SizedBox(height: 20 * scale),

                        // Section 4: Added Panels List
                        ..._addedPanels.map((id) => _buildAddedPanelTile(id, scale)).toList(),

                        SizedBox(height: 30 * scale),
                        _buildPrimaryButton("Submit", ColorPalette.background, scale,onTap: () {
                          context.pushNamed(RouteName.registration_success);
                        },),
                        SizedBox(height: 44 * scale),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- New Widget for Panel ID List ---
  Widget _buildAddedPanelTile(String id, double scale) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10 * scale),
      child: Container(
        height: 50 * scale,
        padding: EdgeInsets.symmetric(horizontal: 16 * scale),
        decoration: BoxDecoration(
          color: const Color(0xFFE3F2FD).withOpacity(0.7),
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
      ),
    );
  }

  // --- Helper Widgets (Keeping your existing style) ---

  Widget _buildSectionCard({required double scale, required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20 * scale),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Center for QR section
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(title, style: GoogleFonts.poppins(fontSize: 18 * scale, fontWeight: FontWeight.w500)),
          ),
          SizedBox(height: 20 * scale),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, double scale, {bool isMultiline = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.lato(fontSize: 16 * scale, fontWeight: FontWeight.w600)),
          SizedBox(height: 8 * scale),
          _buildSimpleInput(hint, scale, isMultiline: isMultiline),
        ],
      ),
    );
  }

  Widget _buildSimpleInput(String hint, double scale, {bool isMultiline = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15 * scale),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10 * scale),
        border: Border.all(color: Colors.white),
      ),
      child: TextField(
        maxLines: isMultiline ? 3 : 1,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          hintStyle: GoogleFonts.lato(color: Colors.black38, fontSize: 16 * scale),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(String text, Color color, double scale, {VoidCallback? onTap}) {
    return GestureDetector( // Add GestureDetector
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFF26A7DF),
          borderRadius: BorderRadius.circular(10 * scale),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16 * scale
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSmallButton(String text, double scale) {
    return Container(
      width: 90 * scale,
      height: 50 * scale,
      decoration: BoxDecoration(
        color: const Color(0xFF26A7DF),
        borderRadius: BorderRadius.circular(6 * scale),
      ),
      child: Center(
        child: Text(text, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildDivider(double scale) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFF484848), thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10 * scale),
          child: Text("OR", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: const Color(0xFF484848), fontSize: 16 * scale)),
        ),
        const Expanded(child: Divider(color: Color(0xFF484848), thickness: 1)),
      ],
    );
  }


}