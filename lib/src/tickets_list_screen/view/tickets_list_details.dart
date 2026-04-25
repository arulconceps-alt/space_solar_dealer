import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  void initState() {
    super.initState();

    context.read<TicketListDetailsBloc>().add(
      LoadTicketsEvent(status: "OPEN"),
    );
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

          if (state.status == TicketListDetailsStatus.success) {
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
    final filtered = tickets.where((t) {
      if (_selectedTab == "All Active") return true;
      if (_selectedTab == "In Progress") return t.status == "Pending";
      return t.status == _selectedTab;
    }).toList();

    return SingleChildScrollView(
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
                      if (_debounce?.isActive ?? false) _debounce!.cancel();

                      _debounce = Timer(const Duration(milliseconds: 500), () {
                        context.read<TicketListDetailsBloc>().add(
                          LoadTicketsEvent(
                            status: "OPEN",
                            search: val,
                          ),
                        );
                      });
                    }
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
                ticketId: ticket.ticketId,
                customerName: ticket.customerName,
                status: ticket.status,
                issue: ticket.issue,
                panelId: ticket.panelId,
                date: ticket.date,
                sla: ticket.sla,
                statusColor: Colors.blue,
                onViewDetails: () {
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierColor: Colors.black54,
                    transitionDuration:
                    const Duration(milliseconds: 300),
                    pageBuilder: (_, __, ___) => const SizedBox(),
                    transitionBuilder:
                        (context, animation, _, child) {
                      return Transform.scale(
                        scale: animation.value,
                        child: Opacity(
                          opacity: animation.value,
                          child: const TicketDetailsDialog(),
                        ),
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
    );
  }

  // ---------------- FAB ----------------

  Widget _buildFigmaFAB(
      double scale, double Function(double) s) {
    return GestureDetector(
      onTap: () {
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierColor: Colors.black54,
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (_, __, ___) =>
              RaiseTicketDialog(parentContext: context),
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
            const Icon(Icons.add, color: Colors.white),
            SizedBox(width: s(10)),
            Text(
              "Raise Ticket",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: s(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}