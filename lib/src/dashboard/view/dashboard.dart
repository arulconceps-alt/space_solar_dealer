import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/app/route_names.dart';
import 'package:space_solar_dealer/src/common/widgets/common_app_bar.dart';
import 'package:space_solar_dealer/src/common/widgets/custom_bottom_navigationbar.dart';
import 'package:space_solar_dealer/src/customer_list/bloc/customer_list_bloc.dart';
import 'package:space_solar_dealer/src/customer_list/view/customer_list_screen.dart';
import 'package:space_solar_dealer/src/dashboard/bloc/dashboard_bloc.dart';
import 'package:space_solar_dealer/src/dashboard/bloc/dashboard_event.dart';
import 'package:space_solar_dealer/src/dashboard/bloc/dashboard_state.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/dashboard_card_design.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/action_card.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/activity_tile.dart';
import 'package:space_solar_dealer/src/profile/view/profile_screen.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/bloc/ticket_list_details_bloc.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/bloc/ticket_list_details_event.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/tickets_list_details.dart';
import 'package:space_solar_dealer/src/total_panel_ids/bloc/total_panel_bloc.dart';
import 'package:space_solar_dealer/src/total_panel_ids/bloc/total_panel_event.dart'
    as panel;

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
  void initState() {
    super.initState();
    context.read<TotalPanelBloc>().add(panel.LoadPanelsEvent());
    context.read<DashboardBloc>().add(LoadDashboardEvent());
  }

  String _formatTime(String dateTime) {
    final date = DateTime.parse(dateTime).toLocal();
    final diff = DateTime.now().difference(date);

    if (diff.inMinutes < 1) return "Just now";
    if (diff.inHours < 1) return "${diff.inMinutes} min ago";
    if (diff.inDays < 1) return "${diff.inHours} hr ago";
    return "${diff.inDays} days ago";
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case "RESOLVED":
        return Colors.green;
      case "PENDING":
        return const Color(0xFFEA1F27);
      case "IN_PROGRESS":
        return ColorPalette.textfiledin;

      default:
        return Colors.grey;
    }
  }

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
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, dashboardState) {
            final dashboard = dashboardState.dashboard;

            final isLoading =
                dashboardState.status == DashboardStatus.loading &&
                _selectedIndex == 0;
            final activities = (dashboard?.recentActivities ?? [])
                .take(5)
                .toList();
            return Stack(
              children: [
                IndexedStack(
                  index: _selectedIndex,
                  children: [
                    // Dashboard Tab (Index 0)
                    RefreshIndicator(
                      onRefresh: () async {
                        context.read<DashboardBloc>().add(LoadDashboardEvent());
                      },
                      child: SingleChildScrollView(
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
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: s(16),
                                      mainAxisSpacing: s(16),
                                      childAspectRatio: w > 600
                                          ? 1.2
                                          : (192 / 185),
                                    ),
                                itemBuilder: (context, index) {
                                  final items = [
                                    {
                                      "title": "Total Panels Sold",
                                      "value":
                                          "${dashboard?.totalPanelsSold ?? 0}",
                                      "subtitle": "",
                                      "color": ColorPalette.background,
                                      "icon":
                                          "assets/images/dashboard/solar_panel.png",
                                      "iconsize": iconLarge,
                                      "route": RouteName.total_panel_list,
                                    },
                                    {
                                      "title": "Total Customers",
                                      "value":
                                          "${dashboard?.totalCustomers ?? 0}",
                                      "subtitle": "",
                                      "color": ColorPalette.pending,
                                      "icon":
                                          "assets/images/dashboard/people.png",
                                      "iconsize": iconMedium,
                                      "route": RouteName.customer_list, // Add navigation route
                                    },
                                    {
                                      "title": "Active Warranties",
                                      "value":
                                          "${dashboard?.activeWarranty ?? 0}",
                                      "subtitle": "Registered",
                                      "color": ColorPalette.active,
                                      "icon":
                                          "assets/images/dashboard/active_shield.png",
                                      "iconsize": iconSmall,
                                      "route": null, // No navigation
                                    },
                                    {
                                      "title": "Tickets",
                                      "value":
                                          "${dashboard?.tickets.total ?? 0}",
                                      "subtitle":
                                          "${dashboard?.tickets.pending ?? 0} Pending",
                                      "color": ColorPalette.alert,
                                      "icon":
                                          "assets/images/dashboard/tickets_notify_icon.png",
                                      "iconsize": iconMedium,
                                      "route": RouteName.ticket_list, // Add navigation route
                                    },
                                  ];
                                  final item = items[index];

                                  return GestureDetector(
                                    onTap: () {
                                      // Navigate if route exists
                                      if (item["route"] != null && item["route"]!.toString().isNotEmpty) {
                                        final routeName = item["route"] as String;
                                        
                                        // Navigate to the screen
                                        context.pushNamed(routeName).then((_) {
                                          // Refresh data when coming back
                                          context.read<DashboardBloc>().add(LoadDashboardEvent());
                                          if (routeName == RouteName.customer_list) {
                                            context.read<CustomerListBloc>().add(LoadCustomers());
                                          } else if (routeName == RouteName.ticket_list) {
                                            context.read<TicketListDetailsBloc>().add(LoadTicketsEvent());
                                          }
                                        });
                                      }
                                    },
                                    child: DashboardCard(
                                      title: item["title"] as String,
                                      value: item["value"] as String,
                                      subtitle: item["subtitle"] as String,
                                      backgroundColor: item["color"] as Color,
                                      imagePath: item["icon"] as String,
                                      iconSize:
                                          item["iconsize"] as double? ??
                                          iconMedium,
                                      route: item["route"] as String? ?? "",
                                    ),
                                  );
                                },
                              ),
                            ),

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
                                  color: ColorPalette.whitetext.withOpacity(
                                    0.4,
                                  ),
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
                                          title: "Register\n Customer",
                                          iconSize: 16,
                                          color: ColorPalette.background,
                                          imagePath:
                                              "assets/images/dashboard/new_user.png",
                                          arrowSvgPath:
                                              "assets/images/home/arrow_right.svg",
                                          onTap: () {
                                            context.pushNamed(
                                              RouteName.customer_register,
                                            ).then((_) {
                                              // Refresh customer list when returning
                                              context.read<CustomerListBloc>().add(LoadCustomers());
                                              // Refresh dashboard
                                              context.read<DashboardBloc>().add(LoadDashboardEvent());
                                            });
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
                                            // Navigate to raise ticket screen
                                            context.pushNamed(
                                              RouteName.ticket_list, // Make sure this route exists
                                            ).then((_) {
                                              // Refresh tickets when returning
                                              context.read<TicketListDetailsBloc>().add(LoadTicketsEvent());
                                              context.read<DashboardBloc>().add(LoadDashboardEvent());
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
                              child: activities.isEmpty
                                  ? Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: s(20),
                                        ),
                                        child: Text(
                                          "No records found",
                                          style: GoogleFonts.poppins(
                                            fontSize: s(14),
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Column(
                                      children: activities.map((activity) {
                                        return ActivityCard(
                                          title: activity.title,
                                          name: activity.customerName,
                                          time: _formatTime(activity.createdAt),
                                          status: activity.status,
                                          statusColor: _getStatusColor(
                                            activity.status,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                            ),

                            SizedBox(height: s(20)),
                          ],
                        ),
                      ),
                    ),

                    // Customer List Tab (Index 1)
                    const CustomerList(),

                    // Tickets List Tab (Index 2)
                    const TicketsListDetails(),

                    // Profile Tab (Index 3)
                    const ProfileScreen(),
                  ],
                ),

                /// LOADER
                if (isLoading)
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        color: Colors.black.withOpacity(0.35),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              ColorPalette.background,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        bottomNavigationBar: SafeArea(
          child: CustomBottomNavBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });

              if (index == 1) {
                context.read<CustomerListBloc>().add(LoadCustomers());
              } else if (index == 2) {
                context.read<TicketListDetailsBloc>().add(LoadTicketsEvent());
              }
            },
          ),
        ),
      ),
    );
  }
}