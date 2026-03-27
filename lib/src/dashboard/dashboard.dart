import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';import 'package:space_solar_dealer/src/common/widgets/app_text_styles.dart';
import 'package:space_solar_dealer/src/common/widgets/custom_bottom_navigationbar.dart';
import 'package:space_solar_dealer/src/customer_list/view/customer_list_screen.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/dashboard_card_design.dart';
import 'package:space_solar_dealer/src/home/widgets/action_card.dart';
import 'package:space_solar_dealer/src/home/widgets/activity_tile.dart';
import 'package:space_solar_dealer/src/login/widgets/logo_widget.dart';
import 'package:space_solar_dealer/src/profile/view/profile_screen.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/tickets_list_details.dart';

import 'view/widgets/app_background.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    double s(double v) => v * scale;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        /// 🔝 APPBAR
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: s(74),
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: LogoWidget(scale: scale),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(s(1)),
            child: Container(
              height: s(1),
              color: ColorPalette.background, // 👈 border color
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: s(20)),
              child: GestureDetector(
                onTap: () {
                  context.push('/notification_screen');
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SvgPicture.asset(
                      "assets/images/home/notification.svg",
                      height: s(20),
                      width: s(20),
                    ),
                    Transform.translate(
                      offset: Offset(s(8), -s(6)),
                      child: Container(
                        padding: EdgeInsets.all(s(3)),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '16',
                          style: TextStyle(
                            fontSize: s(9),
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        /// 📱 BODY
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            /// 🏠 DASHBOARD PAGE
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    SizedBox(height: s(24),),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: s(20)),
                    child: Text(
                      "Good morning, Dealer",
                      style: GoogleFonts.poppins(
                        fontSize: s(20),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF282828),
                      ),
                    ),
                  ),

                  SizedBox(height: s(20)),

                  /// GRID CARDS
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: s(20)),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: s(16),
                        mainAxisSpacing: s(16),
                        childAspectRatio: s(192) / s(177),
                      ),
                      itemBuilder: (context, index) {
                        final items = [
                          {
                            "title": "Panels Sold",
                            "value": "1000",
                            "subtitle": "This month",
                            "color": ColorPalette.background,
                            "icon": "assets/images/dashboard/solar_panel.png",
                          },
                          {
                            "title": "Active Warranties",
                            "value": "105",
                            "subtitle": "Registered",
                            "color": ColorPalette.active,
                            "icon": "assets/images/dashboard/active_shield.png",
                          },
                          {
                            "title": "Tickets",
                            "value": "8",
                            "subtitle": "2 Pending",
                            "color": ColorPalette.alert,
                            "icon": "assets/images/dashboard/tickets_notify_icon.png",
                          },
                          {
                            "title": "Pending Registrations",
                            "value": "6",
                            "subtitle": "This week",
                            "color": ColorPalette.pending,
                            "icon": "assets/images/dashboard/time_icon.png",
                          },
                        ];

                        final item = items[index];

                        return DashboardCard(
                          title: item["title"] as String,
                          value: item["value"] as String,
                          subtitle: item["subtitle"] as String,
                          backgroundColor: item["color"] as Color,
                          imagePath: item["icon"] as String,
                        );
                      },
                    ),
                  ),

                  SizedBox(height: s(16)),

                  /// QUICK ACTIONS
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(s(16)),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      border: Border.all(color: Colors.white.withOpacity(0.4)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Quick Actions', style: GoogleFonts.poppins(
                        fontSize: s(18),
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    color: ColorPalette.bottomtext,
                  ),),
                        SizedBox(height: s(12)),

                        Row(
                          children: [
                            Expanded(
                              child: ActionCard(
                                title: "Register\nNew Customer",
                                color: ColorPalette.background,
                                imagePath:
                                "assets/images/dashboard/new_user.png",
                                arrowSvgPath:
                                "assets/images/home/arrow_right.svg",
                                onTap: () {
                                  context.pushNamed(
                                      RouteName.customer_register);
                                },
                              ),
                            ),
                            SizedBox(width: s(12)),
                            Expanded(
                              child: ActionCard(
                                title: "Raise Tickets",
                                color: ColorPalette.alert,
                                imagePath:
                                "assets/images/dashboard/raise_tickets_icon.png",
                                arrowSvgPath:
                                "assets/images/home/arrow_right.svg",
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = 2;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: s(14)),

                  /// RECENT ACTIVITIES
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: s(20)),
                    child: Text(
                      "Recent Activities",
                      style: GoogleFonts.poppins(
                        fontSize: s(18),
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF282828),
                      ),
                    ),
                  ),

                  SizedBox(height: s(16)),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: s(20)),
                    child: Column(
                      children:  [
                        ActivityCard(
                          title: "Warranty Registered",
                          name: "Rajesh Kumar",
                          time: "1 hour ago",
                          status: "Completed",
                          statusColor: Color(0xFF484848),
                        ),
                        ActivityCard(
                          title: "Ticket Raised",
                          name: "Ajith Kumar",
                          time: "2 hours ago",
                          status: "Pending",
                          statusColor: Color(0xFFEA1F27),
                        ),
                        ActivityCard(
                          title: "Technician Assigned",
                          name: "Rajesh Kumar",
                          time: "2 hours ago",
                          status: "In-Progress",
                          statusColor: ColorPalette.textfiledin,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: s(20)),
                ],
              ),
            ),

            const CustomerList(),
            const TicketsListDetails(),
            const ProfileScreen(),
          ],
        ),

        /// 🔻 BOTTOM NAV
        bottomNavigationBar: SafeArea(
          child: CustomBottomNavBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
  }
