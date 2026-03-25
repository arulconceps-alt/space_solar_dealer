import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/home/widgets/top_header_card.dart';
import 'package:space_solar_dealer/src/register_new_customer/widgets/register_blur_circle.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/custom_Segmented_tab.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/custom_search_bar.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/raise_ticket_dialog.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/ticket_card.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/tickets_details_dialog.dart';

class TicketsListDetails extends StatefulWidget {
  const TicketsListDetails({super.key});

  @override
  State<TicketsListDetails> createState() => _TicketsListDetailsState();
}

class _TicketsListDetailsState extends State<TicketsListDetails> {
  String _selectedTab = "All Active";
  final List<Map<String, dynamic>> tickets = [
    {
      "ticketId": "TKT-001",
      "customerName": "Rohit Sharma",
      "status": "Assigned",
      "issue": "Panel not generating power",
      "panelId": "SS-00012",
      "date": "2025-11-13",
      "sla": "2 hours remaining",
      "color": const Color(0xFF26A7DF),
    },
    {
      "ticketId": "TKT-002",
      "customerName": "Ajith Kumar",
      "status": "Pending",
      "issue": "Low Power Output",
      "panelId": "SS-00012",
      "date": "2025-11-13",
      "sla": "2 hours remaining",
      "color": const Color(0xFFEA1F27),
    },
  ];
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    return Scaffold(
      backgroundColor: const Color(0xFFB5E2F4),
      floatingActionButton: Container(
        width: 174 * scale,
        height: 50 * scale,
        decoration: BoxDecoration(
          color: const Color(0xFF26A7DF),
          borderRadius: BorderRadius.circular(10 * scale),
        ),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (dialogContext) {
                return Center(
                  child: RaiseTicketDialog(
                    parentContext: context, // 👈 IMPORTANT
                  ),
                );
              },
            );
          },
          borderRadius: BorderRadius.circular(10 * scale),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Colors.white, size: 20 * scale),
              SizedBox(width: 8 * scale),
              Text(
                'Raise Ticket',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16 * scale,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Stack(
        children: [

          /// 🔵 BACKGROUND + HEADER
          Positioned.fill(
            child: Stack(
              children: [
                RegisterBlurCircle(left: -146, top: -201, size: 383, color: Colors.white, scale: scale, blur: 60),
                RegisterBlurCircle(left: 209, top: 94, size: 383, color: Colors.white.withOpacity(0.3), scale: scale, blur: 40),
                RegisterBlurCircle(left: -153, top: 575, size: 383, color: Colors.white.withOpacity(0.6), scale: scale, blur: 50),

                TopHeaderCard(
                  scale: scale,
                  notificationCount: "5",
                  onBackTap: null,
                  onNotificationTap: () {
                    context.push('/notification_screen');
                  },
                  showNotification: true,
                ),
              ],
            ),
          ),

          /// ✅ CONTENT BELOW HEADER
          Positioned.fill(
            top: 150 * scale, // 👈 adjust
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 24 * scale),

                    /// TITLE
                    Text(
                      "Tickets",
                      style: TextStyle(
                        fontSize: 24 * scale,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF282828),
                      ),
                    ),

                    Text(
                      "Track and manage customer issue",
                      style: TextStyle(
                        fontSize: 14 * scale,
                        color: const Color(0xCC484848),
                      ),
                    ),

                    SizedBox(height: 16 * scale),

                    /// SEARCH
                    CustomSearchBar(
                      scale: scale,
                      onChanged: (value) {},
                    ),

                    SizedBox(height: 16 * scale),

                    /// TABS
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

                    SizedBox(height: 16 * scale),

                    /// LIST
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          /// 🔹 Filter logic
                          final data = tickets.where((t) {
                            if (_selectedTab == "All Active") return true;

                            /// 🔥 Mapping fix
                            if (_selectedTab == "In Progress") {
                              return t["status"] == "Pending";
                            }

                            return t["status"] == _selectedTab;
                          }).toList();

                          /// 🔹 Empty state
                          if (data.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.inbox, size: 50 * scale, color: Colors.grey),
                                  SizedBox(height: 10 * scale),
                                  Text(
                                    "No Records Found",
                                    style: TextStyle(
                                      fontSize: 16 * scale,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          /// 🔹 List
                          return ListView.builder(
                            padding: EdgeInsets.only(
                              top: 20 * scale,
                              bottom: 80 * scale,
                            ),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final ticket = data[index];

                              return TicketCard(
                                scale: scale,
                                ticketId: ticket["ticketId"],
                                customerName: ticket["customerName"],
                                status: ticket["status"],
                                issue: ticket["issue"],
                                panelId: ticket["panelId"],
                                date: ticket["date"],
                                sla: ticket["sla"],
                                statusColor: ticket["color"],

                                /// 🔥 Dialog call
                                onViewDetails: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (_) => const TicketDetailsDialog(),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
