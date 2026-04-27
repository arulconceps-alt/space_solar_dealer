import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/widgets/common_app_bar.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';
import 'package:space_solar_dealer/src/total_panel_ids/view/widget/pagination_footer.dart';
import 'package:space_solar_dealer/src/total_panel_ids/view/widget/panel_Id_search_box.dart';
import 'package:space_solar_dealer/src/total_panel_ids/view/widget/panel_item_list.dart';

class TotalPanelList extends StatefulWidget {
  const TotalPanelList({super.key});

  @override
  State<TotalPanelList> createState() => _TotalPanelListState();
}

class _TotalPanelListState extends State<TotalPanelList> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> panelData = [
    {"name": "Baranee", "id": "SS-PNID-001"},
    {"name": "Mani", "id": "SS-PNID-002"},
    {"name": "Rahul", "id": "SS-PNID-003"},
    {"name": "Mohan", "id": "SS-PNID-004"},
    {"name": "Rahul", "id": "SS-PNID-005"},
    {"name": "Mani", "id": "SS-PNID-006"},
    {"name": "Mani", "id": "SS-PNID-007"},
    {"name": "Mani", "id": "SS-PNID-008"},
    {"name": "Mani", "id": "SS-PNID-009"},
    {"name": "Mani", "id": "SS-PNID-006"},
    {"name": "Mani", "id": "SS-PNID-007"},
    {"name": "Mani", "id": "SS-PNID-008"},
    {"name": "Mani", "id": "SS-PNID-009"},
  ];
  List<Map<String, String>> filteredData = [];
  // Pagination State
  int currentPage = 1;
  final int itemsPerPage = 8;

  @override
  void initState() {
    super.initState();
    filteredData = panelData;
  }

  // Search Logic
  void _performSearch(String query) {
    setState(() {
      currentPage = 1; // Reset to page 1 on new search
      if (query.isEmpty) {
        filteredData = panelData;
      } else {
        filteredData = panelData.where((item) {
          final nameMatch = item["name"]!.toLowerCase().contains(query.toLowerCase());
          final idMatch = item["id"]!.toLowerCase().contains(query.toLowerCase());
          return nameMatch || idMatch;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;
    double s(double v) => v * scale;
    final bool isEmpty = filteredData.isEmpty;
    final int startIndex = (currentPage - 1) * itemsPerPage;
    final int endIndex = startIndex + itemsPerPage;
    final int totalPages =
    (filteredData.length / itemsPerPage).ceil();
    final List<Map<String, String>> pagedData = filteredData.length > startIndex
        ? filteredData.sublist(startIndex, endIndex > filteredData.length ? filteredData.length : endIndex)
        : [];

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: CommonAppBar(
        scale: scale,
        showBack: true,
        showNotification: false,
        onBackTap: () => context.pop(),
      ),
      body: AppBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: s(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: s(20)),
                        child: PanelIdSearchBox(
                          scale: scale,
                          controller: _searchController,
                          onChanged: _performSearch,
                        ),
                      ),
                      Text(
                        "Panels",
                        style: GoogleFonts.poppins(
                          fontSize: s(20),
                          fontWeight: FontWeight.w600,
                          color: ColorPalette.bottomtext,
                        ),
                      ),
                      isEmpty
                          ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: s(80)),
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
                        itemCount: pagedData.length,
                        itemBuilder: (context, index) {
                          final panel = pagedData[index];
                          return PanelItemList(
                            name: panel["id"]!,
                            isFirst: index == 0,
                            isLast: index == pagedData.length - 1,
                            onTap: () {},
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: s(63), top: s(40)),
                        child: Center(
                          child: PaginationFooter(
                            totalItems: filteredData.length,
                            currentPage: currentPage,
                            onPageChanged: (page) {
                              if (page > totalPages) return;

                              setState(() {
                                currentPage = page;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // FIXED FOOTER PLACEMENT

            ], // End of Column children
          ), // End of SafeArea Column
        ), // End of SafeArea
      ), // End of AppBackground
    ); // End of Scaffold
  }
}
