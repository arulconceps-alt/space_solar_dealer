import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';
import 'package:space_solar_dealer/src/common/widgets/common_app_bar.dart';
import 'package:space_solar_dealer/src/common/widgets/custom_bottom_navigationbar.dart';
import 'package:space_solar_dealer/src/customer_list/bloc/customer_list_bloc.dart';
import 'package:space_solar_dealer/src/customer_list/repo/customer_list_repositary.dart';
import 'package:space_solar_dealer/src/customer_list/view/customer_list_screen.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/dashboard_card_design.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/action_card.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/activity_tile.dart';
import 'package:space_solar_dealer/src/profile/view/profile_screen.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/tickets_list_details.dart';

import 'widgets/app_background.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  double iconSmall = 22.0;
  double iconMedium = 24.0;
  double iconLarge = 28.0;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    double s(double v) => v * scale;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CommonAppBar(
        scale: scale,
        showBack: false,
        showNotification: true,
      ),
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: s(24)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: s(20)),
                    child: Text(
                      "Good morning, Dealer",
                      style: GoogleFonts.poppins(
                         fontSize: s(20),
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.bottomtext,
                      ),
                    ),
                  ),

                  SizedBox(height: s(20)),
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
                        // FIX: Adjust ratio for tablets to prevent vertical overflow
                        childAspectRatio: w > 600 ? 1.2 : (192 / 185),
                      ),
                      itemBuilder: (context, index) {
                        // Define the list clearly inside the builder
                        final List<Map<String, dynamic>> items = [
                          {
                            "title": "Total Panels Sold",
                            "value": "251000",
                            "subtitle": "",
                            "color": ColorPalette.background,
                            "icon": "assets/images/dashboard/solar_panel.png",
                            "iconsize": iconLarge,
                          },
                          {
                            "title": "Total Customers",
                            "value": "5000",
                            "subtitle": "",
                            "color": ColorPalette.pending,
                            "icon": "assets/images/dashboard/people.png",
                            "iconsize": iconMedium,
                          },
                          {
                            "title": "Active Warranties",
                            "value": "105",
                            "subtitle": "Registered",
                            "color": ColorPalette.active,
                            "icon": "assets/images/dashboard/active_shield.png",
                            "iconsize": iconSmall,
                          },
                          {
                            "title": "Tickets",
                            "value": "8",
                            "subtitle": "2 Pending",
                            "color": ColorPalette.alert,
                            "icon": "assets/images/dashboard/tickets_notify_icon.png",
                            "iconsize": iconMedium,
                          },
                        ];

                        // Now 'item' is defined correctly within this scope
                        final item = items[index];

                        return GestureDetector(
                          onTap: () {
                            final title = item["title"];

                            if (title == "Total Panels Sold") {
                              context.pushNamed(RouteName.total_panel_list);
                            }
                          },
                          child: DashboardCard(
                            title: item["title"] as String,
                            value: item["value"] as String,
                            subtitle: item["subtitle"] as String,
                            backgroundColor: item["color"] as Color,
                            imagePath: item["icon"] as String,
                            iconSize: item["iconsize"] as double? ?? iconMedium,
                          ),
                        );
                      },
                    ),
                  ),
                  /*Padding(
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
                            "title": "Total Panels Sold",
                            "value": "251000",
                            "subtitle": "",
                            "color": ColorPalette.background,
                            "icon": "assets/images/dashboard/solar_panel.png",
                            "iconsize": iconLarge,
                          },
                          {
                            "title": "Total Customers",
                            "value": "5000",
                            "subtitle": "",
                            "color": ColorPalette.pending,
                            "icon": "assets/images/dashboard/people.png",
                            "iconsize": iconMedium,
                          },
                          {
                            "title": "Active Warranties",
                            "value": "105",
                            "subtitle": "Registered",
                            "color": ColorPalette.active,
                            "icon":
                            "assets/images/dashboard/active_shield.png",
                            "iconsize": iconSmall,
                          },
                          {
                            "title": "Tickets",
                            "value": "8",
                            "subtitle": "2 Pending",
                            "color": ColorPalette.alert,
                            "icon":  "assets/images/dashboard/tickets_notify_icon.png",
                            "iconsize": iconMedium,
                          },
                        ];

                        final item = items[index];

                        return DashboardCard(
                          title: item["title"] as String,
                          value: item["value"] as String,
                          subtitle: item["subtitle"] as String,
                          backgroundColor: item["color"] as Color,
                          imagePath: item["icon"] as String,
                          iconSize: item["iconsize"] as double? ?? iconMedium,
                        );
                      },
                    ),
                  ),*/

                  SizedBox(height: s(16)),

                  /// QUICK ACTIONS
                  Container(
                    height: s(208),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: s(16),
                      horizontal: s(20),
                    ),
                    decoration: BoxDecoration(
                      color: ColorPalette.whitetext.withOpacity(0.50),
                      border: Border.all(
                        color: ColorPalette.whitetext.withOpacity(0.4),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Actions',
                          style: GoogleFonts.poppins(
                            fontSize: s(18),
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                            color: ColorPalette.bottomtext,
                          ),
                        ),
                        SizedBox(height: s(14)),

                        Row(
                          children: [
                            Expanded(
                              child: ActionCard(
                                title: "Register\nNew Customer",
                                iconSize: 16,
                                color: ColorPalette.background,
                                imagePath:
                                    "assets/images/dashboard/new_user.png",
                                arrowSvgPath:
                                    "assets/images/home/arrow_right.svg",
                                onTap: () {
                                  context.pushNamed(
                                    RouteName.customer_register,
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: s(16)),
                            Expanded(
                              child: ActionCard(
                                title: "Raise Tickets",
                                iconSize: 22,
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

                  SizedBox(height: s(16)),

                  /// RECENT ACTIVITIES
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: s(20)),
                    child: Text(
                      "Recent Activities",
                      style: GoogleFonts.poppins(
                        fontSize: s(18),
                        fontWeight: FontWeight.w500,
                        color: ColorPalette.bottomtext,
                      ),
                    ),
                  ),

                  SizedBox(height: s(14.45)),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: s(20)),
                    child: Column(
                      children: [
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
            BlocProvider(
              create: (context) => CustomerListBloc(
                repository: CustomerListRepositary(
                  context.read<ApiRepository>(),
                ),
              )..add(LoadCustomers()),
              child: const CustomerList(),
            ),
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
