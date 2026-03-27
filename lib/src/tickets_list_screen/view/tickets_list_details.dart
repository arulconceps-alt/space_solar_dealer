import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/ticket_card.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/custom_search_bar.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/custom_Segmented_tab.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/widgets/raise_ticket_dialog.dart';
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
      "statusColor": const Color(0xFF26A7DF),
    },
    {
      "ticketId": "TKT-002",
      "customerName": "Ajith Kumar",
      "status": "Pending",
      "issue": "Low Power Output",
      "panelId": "SS-00012",
      "date": "2025-11-13",
      "sla": "2 hours remaining",
      "statusColor": const Color(0xFFEA1F27),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    double s(double v) => v * scale;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: s(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: s(24)),

                    /// TITLE
                    Text(
                      'Tickets',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF282828),
                        fontSize: s(24), // ✅ scaled
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    /// SUBTITLE
                    Text(
                      'Track and manage customer issue',
                      style: GoogleFonts.lato(
                        color: const Color(0xCC484848),
                        fontSize: s(14),
                      ),
                    ),

                    SizedBox(height: s(17)),

                    /// SEARCH
                    CustomSearchBar(
                      scale: scale,
                      onChanged: (val) {},
                    ),

                    SizedBox(height: s(16)),

                    /// TABS
                    CustomSegmentedTab(
                      scale: scale,
                      tabs: const [
                        "All Active",
                        "Assigned",
                        "In Progress",
                        "Resolved"
                      ],
                      selectedTab: _selectedTab,
                      onTabChanged: (newTab) {
                        setState(() => _selectedTab = newTab);
                      },
                    ),

                    SizedBox(height: s(16)),
                  ],
                ),
              ),

              /// ✅ LIST (PART OF MAIN SCROLL)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return _buildScrollableTicketList(scale, s);
                },
              ),

              SizedBox(height: s(100)), // space for FAB
            ],
          ),
        ),
      ),

      /// ✅ FIXED FLOATING BUTTON
      floatingActionButton: _buildFigmaFAB(s),
    );
  }

  Widget _buildScrollableTicketList(double scale, double Function(double) s) {
    final filtered = tickets.where((t) {
      if (_selectedTab == "All Active") return true;
      if (_selectedTab == "In Progress") return t["status"] == "Pending";
      return t["status"] == _selectedTab;
    }).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Text(
          "No records found",
          style: GoogleFonts.lato(
            color: const Color(0xCC484848),
            fontSize: s(14), // ✅ scaled
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true, // ✅ IMPORTANT
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(s(20), 0, s(20), s(100)), // ✅ scaled
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final ticket = filtered[index];
        return TicketCard(
          scale: scale,
          ticketId: ticket["ticketId"],
          customerName: ticket["customerName"],
          status: ticket["status"],
          issue: ticket["issue"],
          panelId: ticket["panelId"],
          date: ticket["date"],
          sla: ticket["sla"],
          statusColor: ticket["statusColor"],
          onViewDetails: () {
            showDialog(
              context: context,
              builder: (_) => const TicketDetailsDialog(),
            );
          },
        );
      },
    );
  }

  Widget _buildFigmaFAB(double Function(double) s) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (dialogContext) =>
              RaiseTicketDialog(parentContext: context),
        );
      },
      child: Container(
        width: s(174),
        height: s(50),
        decoration: BoxDecoration(
          color: const Color(0xFF26A7DF),
          borderRadius: BorderRadius.circular(s(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.white, size: s(20)),
            SizedBox(width: s(8)),
            Text(
              'Raise Ticket',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: s(16),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}