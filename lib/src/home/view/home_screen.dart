import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';
import 'package:space_solar_dealer/src/common/widgets/custom_bottom_navigationbar.dart';
import 'package:space_solar_dealer/src/customer_list/view/customer_list_screen.dart';
import 'package:space_solar_dealer/src/home/widgets/action_card.dart';
import 'package:space_solar_dealer/src/home/widgets/activity_tile.dart';
import 'package:space_solar_dealer/src/home/widgets/dashboard_card.dart';
import 'package:space_solar_dealer/src/home/widgets/top_header_card.dart';
import 'package:space_solar_dealer/src/notifications/view/notification_screen.dart';
import 'package:space_solar_dealer/src/profile/view/profile_screen.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/tickets_list_details.dart';

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
          const CustomerList(),
          const TicketsListDetails(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: CustomBottomNavBar(
          currentIndex: _selectedIndex,
          scale: scale,
          onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
          },
        ),
      ),
    );
  }

  Widget _buildDashboardView(double w, double scale) {
    return Stack(
      children: [
        /// 🔵 BACKGROUND + HEADER (FIXED)
        Positioned.fill(
          child: Stack(
            children: [
              _buildBlurredCircle(163, 956, 383, Colors.white.withOpacity(0.40), scale, 40),
              _buildBlurredCircle(-153, 575, 383, Colors.white.withOpacity(0.60), scale, 50),
              _buildBlurredCircle(154, 108, 383, Colors.white.withOpacity(0.50), scale, 40),
              _buildBlurredCircle(-146, -201, 383, Colors.white, scale, 60),

              TopHeaderCard(
                scale: scale,
                onBackTap: null,
                onNotificationTap: () {
                  context.push('/notification_screen');
                },
                showNotification: true,
              ),

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
            ],
          ),
        ),

        /// 🔥 SCROLLABLE CONTENT ONLY
        Positioned.fill(
          top: 200 * scale, // 🔥 VERY IMPORTANT (below header)
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20 * scale),

                /// Dashboard Cards
                Wrap(
                  spacing: 20 * scale,
                  runSpacing: 20 * scale,
                  children: [
                    DashboardCard(
                      title: "Panels Sold",
                      value: "1000",
                      subtitle: "This month",
                      backgroundColor: ColorPalette.background,
                      imagePath: "assets/images/dashboard/solar_panel.png",
                      scale: scale,
                    ),
                    DashboardCard(
                      title: "Active Warranties",
                      value: "105",
                      subtitle: "Registered",
                      backgroundColor: ColorPalette.active,
                      imagePath: "assets/images/dashboard/active_shield.png",
                      scale: scale,
                    ),
                    DashboardCard(
                      title: "Tickets",
                      value: "8",
                      subtitle: "2 Pending",
                      backgroundColor: ColorPalette.alert,
                      imagePath: "assets/images/dashboard/tickets_notify_icon.png",
                      scale: scale,
                    ),
                    DashboardCard(
                      title: "Pending Registrations",
                      value: "6",
                      subtitle: "This week",
                      backgroundColor: ColorPalette.pending,
                      imagePath: "assets/images/dashboard/time_icon.png",
                      scale: scale,
                    ),
                  ],
                ),

                SizedBox(height: 30 * scale),

                /// Quick Actions
                Container(
                  width: double.infinity,
                    decoration: ShapeDecoration(
                      color: Colors.white.withValues(alpha: 0.50),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(20 * scale),
                      ),
                    ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scale,vertical: 16 * scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Quick Actions',
                            style: GoogleFonts.poppins(
                                fontSize: 18 * scale,
                                fontWeight: FontWeight.w500)),

                        SizedBox(height: 10 * scale),

                        Row(
                          children: [
                            Expanded(
                              child: ActionCard(
                                title: "Register \nNew Customer",
                                color: ColorPalette.background,
                                imagePath: "assets/images/dashboard/new_user.png",
                                scale: scale,
                                onTap: () {
                                  context.pushNamed(RouteName.customer_register);
                                },
                              ),
                            ),
                            SizedBox(width: 12 * scale),
                            Expanded(
                              child: ActionCard(
                                title: "Raise Tickets",
                                color: ColorPalette.alert,
                                imagePath: "assets/images/dashboard/raise_tickets_icon.png",
                                scale: scale,
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = 2; // Tickets tab index
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 14 * scale),

                /// Recent Activities
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10 * scale),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent Activities',
                        style: TextStyle(
                          color: const Color(0xFF282828),
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      SizedBox(height: 10 * scale),

                      ActivityTile(
                        title: 'Warranty Registered',
                        name: 'Rajesh Kumar',
                        status: 'Completed',
                        time: '1 hour ago',
                        statusColor: const Color(0xFF484848), // Or use Color(0xFF484848)
                      ),

                      SizedBox(height: 10 * scale),

                      ActivityTile(
                        title: "Ticket Raised",
                        name: "Ajith Kumar",
                        status: "Pending",
                        time: "2 hours ago",
                        statusColor: const Color(0xFFEA1F27), // ✅ changed
                      ),
                      SizedBox(height: 10 * scale),
                      ActivityTile(
                        title: "Technician Assigned",
                        name: "Rajesh Kumar",
                        status: "In-Progress",
                        time: "2 hours ago",
                        statusColor: Colors.black, // 🔥 important
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 19 * scale),
              ],
            ),
          ),
        ),
      ],
    );
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