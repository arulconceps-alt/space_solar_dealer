import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';
import 'package:space_solar_dealer/src/common/widgets/custom_bottom_navigationbar.dart';
import 'package:space_solar_dealer/src/home/widgets/action_card.dart';
import 'package:space_solar_dealer/src/home/widgets/activity_tile.dart';
import 'package:space_solar_dealer/src/home/widgets/dashboard_card.dart';
import 'package:space_solar_dealer/src/home/widgets/top_header_card.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    return Scaffold(
      backgroundColor: const Color(0xFFB5E2F4),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildDashboardView(w, scale),
          const Center(child: Text("Customer Screen")),
          const Center(child: Text("Tickets Screen")),
          const Center(child: Text("Profile Screen")),
        ],
      ),
      // --- CALLING YOUR SEPARATE WIDGET HERE ---
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        scale: scale,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildDashboardView(double w, double scale) {
    return SingleChildScrollView(
      child: Container(
        width: w,
        height: 1308 * scale,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFFB5E2F4)),
        child: Stack(
          children: [
            _buildBlurredCircle(163, 956, 383, Colors.white.withOpacity(0.40), scale, 40),
            _buildBlurredCircle(-153, 575, 383, Colors.white.withOpacity(0.60), scale, 50),
            _buildBlurredCircle(154, 108, 383, Colors.white.withOpacity(0.50), scale, 40),
            _buildBlurredCircle(-146, -201, 383, Colors.white, scale, 60),

            TopHeaderCard(scale: scale),

            Positioned(
              left: 20 * scale,
              top: 158 * scale,
              child: Text(
                'Good morning, Dealer',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF282828),
                  fontSize: 20 * scale,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Dashboard Grid
            _positionedCard(20, 208, scale, DashboardCard(
                title: "Panels Sold", value: "1000", subtitle: "This month",
                backgroundColor: ColorPalette.background, imagePath: "assets/images/dashboard/solar_panel.png", scale: scale)),

            _positionedCard(228, 208, scale, DashboardCard(
                title: "Active Warranties", value: "105", subtitle: "Registered",
                backgroundColor: ColorPalette.active, imagePath: "assets/images/dashboard/active_shield.png", scale: scale)),

            _positionedCard(20, 401, scale, DashboardCard(
                title: "Tickets", value: "8", subtitle: "2 Pending",
                backgroundColor: ColorPalette.alert, imagePath: "assets/images/dashboard/tickets_notify_icon.png", scale: scale)),

            _positionedCard(228, 401, scale, DashboardCard(
                title: "Pending Registrations", value: "6", subtitle: "This week",
                backgroundColor: ColorPalette.pending, imagePath: "assets/images/dashboard/time_icon.png", scale: scale)),

            // Quick Actions Section
            Positioned(
              left: 0, top: 594 * scale,
              child: Container(
                width: 440 * scale, height: 208 * scale,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.30),
                  border: const Border(top: BorderSide(color: Colors.white), bottom: BorderSide(color: Colors.white)),
                ),
              ),
            ),

            Positioned(
              left: 20 * scale, top: 610 * scale,
              child: Text('Quick Actions', style: GoogleFonts.poppins(color: const Color(0xFF282828), fontSize: 18 * scale, fontWeight: FontWeight.w500)),
            ),

            _positionedCard(
              20,
              649,
              scale,
              ActionCard(
                title: "Register \nNew Customer",
                color: ColorPalette.background,
                imagePath: "assets/images/dashboard/new_user.png",
                scale: scale,
                onTap: () {
                  // Use pushNamed to go to your defined route
                  context.pushNamed(RouteName.customer_register);
                },
              ),
            ),
            _positionedCard(
              228, 649,
              scale,
              ActionCard(
                title: "Raise Tickets",
                color: ColorPalette.alert,
                imagePath: "assets/images/dashboard/raise_tickets_icon.png",
                scale: scale,
                onTap: () {

                },
              ),
            ),
            // Recent Activity
            Positioned(
              left: 19 * scale, top: 816 * scale,
              child: Text('Recent Activities', style: GoogleFonts.poppins(color: const Color(0xFF282828), fontSize: 18 * scale, fontWeight: FontWeight.w500)),
            ),

            _positionedCard(20, 857, scale, ActivityTile(
                title: "Warranty Registered", name: "Rajesh Kumar", status: "Completed",
                time: "1 hours ago", color: const Color(0xFF484848), scale: scale)),

            _positionedCard(20, 973, scale, ActivityTile(
                title: "Ticket Raised", name: "Ajith Kumar", status: "Pending",
                time: "2 hours ago", color: const Color(0xFFEA1F27).withOpacity(0.6), scale: scale)),
          ],
        ),
      ),
    );
  }

  // Helper to keep the Stack clean
  Widget _positionedCard(double left, double top, double scale, Widget child) {
    return Positioned(left: left * scale, top: top * scale, child: child);
  }

  Widget _buildBlurredCircle(double left, double top, double size, Color color, double scale, double blurAmount) {
    return Positioned(
      left: left * scale, top: top * scale,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
        child: Container(width: size * scale, height: size * scale, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      ),
    );
  }
}