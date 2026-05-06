import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/models/ticket_model.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/bloc/ticket_list_details_bloc.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/bloc/ticket_list_details_event.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/bloc/ticket_list_details_state.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/widgets/custom_Segmented_tab.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/widgets/custom_search_bar.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/widgets/raise_ticket_dialog.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/widgets/ticket_card.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/widgets/tickets_details_dialog.dart';

class TicketsListDetails extends StatefulWidget {
  const TicketsListDetails({super.key});

  @override
  State<TicketsListDetails> createState() => _TicketsListDetailsState();
}

class _TicketsListDetailsState extends State<TicketsListDetails> {
  String _selectedTab = "All Active";
  Timer? _debounce;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    context.read<TicketListDetailsBloc>().add(LoadTicketsEvent());
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    // Reset search and reload fresh data from API
    setState(() => _searchQuery = "");
    context.read<TicketListDetailsBloc>().add(LoadTicketsEvent());
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'assigned':
        return const Color(0xFF26A7DF);
      case 'pending':
      case 'in progress':
        return const Color(0xFFEF5350);
      case 'resolved':
        return const Color(0xFF4CAF50);
      default:
        return Colors.grey;
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'Assigned':
        return const Color(0xFF26A7DF);
      case 'Pending':
        return const Color(0xFFF44336);
      case 'Resolved':
        return const Color(0xFF4CAF50);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    double s(double v) => v * scale;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<TicketListDetailsBloc, TicketListDetailsState>(
        builder: (context, state) {
          if (state.status == TicketListDetailsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == TicketListDetailsStatus.failure) {
            return Center(child: Text(state.message));
          }

          if (state.status == TicketListDetailsStatus.success ||
              state.status == TicketListDetailsStatus.create) {
            return _buildUI(context, state.tickets, scale, s);
          }

          return const SizedBox();
        },
      ),
      floatingActionButton: _buildFigmaFAB(scale, s),
    );
  }

  // ---------------- UI ----------------

  Widget _buildUI(
    BuildContext context,
    List<TicketModel> tickets,
    double scale,
    double Function(double) s,
  ) {
    // ── Client-side filter: Tab + Search (no BLoC reload needed) ──
    final filtered = tickets.where((t) {
      final status = t.status.toLowerCase().replaceAll("_", " ");

      // Tab filter
      bool tabMatch = false;
      if (_selectedTab == "All Active") {
        tabMatch = true;
      } else if (_selectedTab == "In Progress") {
        tabMatch = status == "in progress";
      } else if (_selectedTab == "Assigned") {
        tabMatch = status == "assigned";
      } else if (_selectedTab == "Resolved") {
        tabMatch = status == "resolved";
      }

      if (!tabMatch) return false;

      // Search filter — Ticket ID, Panel ID, Customer Name
      if (_searchQuery.isEmpty) return true;

      final ticketNumber = t.ticketNumber.toLowerCase();
      final panelId = (t.panelId ?? "").toLowerCase();
      final customerName = (t.customerName ?? "").toLowerCase();

      return ticketNumber.contains(_searchQuery) ||
          panelId.contains(_searchQuery) ||
          customerName.contains(_searchQuery);
    }).toList();

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: ColorPalette.background,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: s(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: s(24)),

                  Text(
                    'Tickets',
                    style: GoogleFonts.poppins(
                      fontSize: s(20),
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.bottomtext,
                    ),
                  ),

                  SizedBox(height: s(4)),

                  Text(
                    'Track and manage customer issue',
                    style: GoogleFonts.lato(
                      color: ColorPalette.textfiledin.withOpacity(0.8),
                      fontSize: s(14),
                    ),
                  ),

                  SizedBox(height: s(20)),

                  CustomSearchBar(
                    scale: scale,
                    onChanged: (val) {
                      // ✅ Only setState — instant client-side filter
                      // No BLoC event = no loading state = no page flash/refresh
                      setState(() {
                        _searchQuery = val.toLowerCase().trim();
                      });
                    },
                  ),

                  SizedBox(height: s(16)),

                  CustomSegmentedTab(
                    scale: scale,
                    tabs: const [
                      "All Active",
                      "Assigned",
                      "In Progress",
                      "Resolved",
                    ],
                    selectedTab: _selectedTab,
                    onTabChanged: (tab) {
                      setState(() => _selectedTab = tab);
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: s(16)),

            filtered.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(s(30)),
                      child: Text(
                        "No records found",
                        style: GoogleFonts.lato(
                          fontSize: s(14),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: s(20)),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final ticket = filtered[index];

                      return TicketCard(
                        scale: scale,
                        ticketNumber: ticket.ticketNumber,
                        customerName: ticket.customerName ?? "N/A",
                        status: ticket.status,
                        issue: ticket.issue ?? "No Issue",
                        panelId: ticket.panelId ?? "N/A",
                        date: DateFormat('yyyy-MM-dd').format(ticket.createdAt),
                        sla: getSla(ticket.createdAt, ticket.priority ?? "Low"),
                        statusColor: _getStatusColor(ticket.status),
                        statusBgColor: _getStatusColor(
                          ticket.status,
                        ).withOpacity(0.15),
                        onViewDetails: () {
                         showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  backgroundColor: Colors.transparent,
  builder: (context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, controller) {
        return TicketDetailsDialog(
          ticket: ticket,
          scrollController: controller,
        );
      },
    );
  },
);
                        },
                      );
                    },
                  ),

            SizedBox(height: s(100)),
          ],
        ),
      ),
    );
  }

  Widget _buildFigmaFAB(double scale, double Function(double) s) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return DraggableScrollableSheet(
              initialChildSize: 0.85,
              minChildSize: 0.5,
              maxChildSize: 0.95, 
              builder: (_, controller) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: RaiseTicketDialog(
                    parentContext: context,
                    scrollController: controller,
                  ),
                );
              },
            );
          },
        );
      },
      child: Container(
        width: s(174),
        height: s(50),
        decoration: BoxDecoration(
          color: ColorPalette.background,
          borderRadius: BorderRadius.circular(s(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/ticket/add_icon.png",
              height: s(22),
              width: s(22),
              color: ColorPalette.whitetext,
            ),
            SizedBox(width: s(12)),
            Text(
              'Raise Ticket',
              style: GoogleFonts.poppins(
                color: ColorPalette.whitetext,
                fontSize: s(16),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getSla(DateTime createdAt, String priority) {
    final hours = priority.toLowerCase() == 'high' ? 2 : 24;
    final expiry = createdAt.add(Duration(hours: hours));
    final diff = expiry.difference(DateTime.now());

    if (diff.isNegative) return "SLA Breached";

    return "${diff.inHours}h ${diff.inMinutes % 60}m remaining";
  }
}
