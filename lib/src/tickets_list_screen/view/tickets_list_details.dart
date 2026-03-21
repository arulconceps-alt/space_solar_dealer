import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/home/widgets/top_header_card.dart';
import 'package:space_solar_dealer/src/register_new_customer/widgets/register_blur_circle.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/custom_Segmented_tab.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/custom_search_bar.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/ticket_card.dart';

class TicketsListDetails extends StatefulWidget {
  const TicketsListDetails({super.key});

  @override
  State<TicketsListDetails> createState() => _TicketsListDetailsState();
}

class _TicketsListDetailsState extends State<TicketsListDetails> {
  String _selectedTab = "All Active";
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    return Scaffold(
      backgroundColor: const Color(0xFFB5E2F4),
      body: Stack(
        children: [
          RegisterBlurCircle(left: -146, top: -201, size: 383, color: Colors.white, scale: scale, blur: 60),
          RegisterBlurCircle(left: 209, top: 94, size: 383, color: Colors.white.withOpacity(0.3), scale: scale, blur: 40),
          RegisterBlurCircle(left: -153, top: 575, size: 383, color: Colors.white.withOpacity(0.6), scale: scale, blur: 50),

          SafeArea(
            child: Column(
              children: [
                TopHeaderCard(
                  scale: scale,
                  notificationCount: "16",
                  onBackTap: null,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24 * scale),

                        Text(
                          "Tickets",
                          style: TextStyle(
                            fontSize: 24 * scale,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF282828),
                          ),
                        ),

                        Text(
                          "Track and manage customer issue",
                          style: TextStyle(
                            fontSize: 14 * scale,
                            fontFamily: 'Lato',
                            color: const Color(0xCC484848),
                          ),
                        ),

                        SizedBox(height: 16 * scale),
                        CustomSearchBar(
                          scale: scale,
                          onChanged: (value) {
                            print("Searching for: $value");
                          },
                        ),
                        SizedBox(height: 16 * scale), // Height set to 16 as requested
                        CustomSegmentedTab(
                          scale: scale,
                          tabs: const ["All Active", "Assigned", "In Progress", "Resolved"],
                          selectedTab: _selectedTab,
                          onTabChanged: (newTab) {
                            setState(() {
                              _selectedTab = newTab;
                            });
                          },
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 16 * scale, bottom: 80 * scale), // Space for FAB or bottom
                            itemCount: 2, // Example: showing 2 cards
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return TicketCard(
                                  scale: scale,
                                  ticketId: "TKT-001",
                                  customerName: "Rohit Sharma",
                                  status: "Assigned",
                                  issue: "Panel not generating power",
                                  panelId: "SS-00012",
                                  date: "2025-11-13",
                                  sla: "2 hours remaining",
                                  statusColor: const Color(0xFF26A7DF), // Theme Blue
                                  onViewDetails: () => context.push('/ticket-details'),
                                );
                              } else {
                                return TicketCard(
                                  scale: scale,
                                  ticketId: "TKT-002",
                                  customerName: "Ajith Kumar",
                                  status: "Pending",
                                  issue: "Low Power Output",
                                  panelId: "SS-00012",
                                  date: "2025-11-13",
                                  sla: "2 hours remaining",
                                  statusColor: const Color(0xFFEA1F27), // Red for Pending
                                  onViewDetails: () => context.push('/ticket-details'),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
}
