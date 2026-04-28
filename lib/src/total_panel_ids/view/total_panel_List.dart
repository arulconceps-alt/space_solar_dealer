import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/widgets/common_app_bar.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';
import 'package:space_solar_dealer/src/total_panel_ids/bloc/total_panel_bloc.dart';
import 'package:space_solar_dealer/src/total_panel_ids/bloc/total_panel_state.dart';
import 'package:space_solar_dealer/src/total_panel_ids/view/widget/pagination_footer.dart';
import 'package:space_solar_dealer/src/total_panel_ids/view/widget/panel_Id_search_box.dart';
import 'package:space_solar_dealer/src/total_panel_ids/view/widget/panel_item_list.dart';

import '../bloc/total_panel_event.dart';

class TotalPanelList extends StatefulWidget {
  const TotalPanelList({super.key});

  @override
  State<TotalPanelList> createState() => _TotalPanelListState();
}

class _TotalPanelListState extends State<TotalPanelList> {
  final TextEditingController _searchController = TextEditingController();

  final int itemsPerPage = 8;

  @override
  void initState() {
    super.initState();
    context.read<TotalPanelBloc>().add(LoadPanelsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;
    double s(double v) => v * scale;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: CommonAppBar(
        scale: scale,
        showBack: true,
        showNotification: false,
        onBackTap: () {
          context.go('/dashboard'); // safer than pop
        },
      ),
      body: AppBackground(
        child: SafeArea(
          child: BlocBuilder<TotalPanelBloc, TotalPanelState>(
            builder: (context, state) {

              if (state.status == TotalPanelStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.status == TotalPanelStatus.failure) {
                return Center(child: Text(state.message));
              }

              /// 🔍 FILTER DATA
              final filtered = state.panels.where((panel) {
                final q = state.searchQuery.toLowerCase();
                return panel.serialNumber.toLowerCase().contains(q);
              }).toList();

              /// 📄 PAGINATION
              final start = (state.currentPage - 1) * itemsPerPage;
              final end = start + itemsPerPage;

              final paged = filtered.length > start
                  ? filtered.sublist(start, end > filtered.length ? filtered.length : end)
                  : [];

              final totalPages = (filtered.length / itemsPerPage).ceil();

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: s(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(height: s(20)),

                          /// SEARCH
                          PanelIdSearchBox(
                            scale: scale,
                            controller: _searchController,
                            onChanged: (value) {
                              context.read<TotalPanelBloc>().add(
                                SearchPanelEvent(value),
                              );
                            },
                          ),

                          SizedBox(height: s(20)),

                          Text(
                            "Panels",
                            style: GoogleFonts.poppins(
                              fontSize: s(20),
                              fontWeight: FontWeight.w600,
                              color: ColorPalette.bottomtext,
                            ),
                          ),

                          /// LIST
                          paged.isEmpty
                              ? Padding(
                            padding: EdgeInsets.only(top: s(80)),
                            child: Center(
                              child: Text(
                                "No Panels Found",
                                style: GoogleFonts.poppins(
                                  fontSize: s(16),
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                              : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(vertical: s(20)),
                            itemCount: paged.length,
                            itemBuilder: (context, index) {
                              final panel = paged[index];

                              return PanelItemList(
                                panel: panel,
                                name: panel.serialNumber, // 👈 FIXED
                                isFirst: index == 0,
                                isLast: index == paged.length - 1,
                                onTap: () {},
                              );
                            },
                          ),

                          SizedBox(height: s(30)),

                          /// PAGINATION
                          Center(
                            child: PaginationFooter(
                              totalItems: filtered.length,
                              currentPage: state.currentPage,
                              onPageChanged: (page) {
                                if (page > totalPages || page < 1) return;

                                context.read<TotalPanelBloc>().add(
                                  LoadPanelsEvent(page: page),
                                );
                              },
                            ),
                          ),

                          SizedBox(height: s(60)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
