import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/models/customer_model.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';
import 'package:space_solar_dealer/src/common/widgets/common_app_bar.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';
import 'package:space_solar_dealer/src/register_new_customer/repo/new_register_repositary.dart';
import 'package:space_solar_dealer/src/total_panel_ids/bloc/total_panel_bloc.dart';
import 'package:space_solar_dealer/src/total_panel_ids/bloc/total_panel_event.dart';
import 'package:space_solar_dealer/src/total_panel_ids/bloc/total_panel_state.dart';
import 'package:space_solar_dealer/src/total_panel_ids/view/widget/panel_Id_search_box.dart';
import 'package:space_solar_dealer/src/total_panel_ids/view/widget/panel_item_list.dart';

class TotalPanelList extends StatefulWidget {
  final String? customerId;

  const TotalPanelList({super.key, this.customerId});

  @override
  State<TotalPanelList> createState() => _TotalPanelListState();
}

class _TotalPanelListState extends State<TotalPanelList> {
  CustomerModel? _selectedCustomer;
  final TextEditingController _selectedCustomerController =
      TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  late NewRegisterRepositary _newRegisterRepository;

  List<CustomerModel> _allCustomers = [];
  List<CustomerModel> _searchResults = [];

  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();

    final apiRepository = context.read<ApiRepository>();
    _newRegisterRepository = NewRegisterRepositary(apiRepository);

    _fetchAllCustomers();

    context.read<TotalPanelBloc>().add(
      LoadPanelsEvent(customerId: widget.customerId),
    );
  }

  Future<void> _fetchAllCustomers() async {
    try {
      final customers = await _newRegisterRepository.getCustomers();

      setState(() {
        _allCustomers = (customers as List)
            .map((e) => CustomerModel.fromJson(e))
            .toList();
      });
    } catch (e) {
      debugPrint("Error fetching customers: $e");
    }
  }

  void _onSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _showSuggestions = false;
      });

      context.read<TotalPanelBloc>().add(
        const LoadPanelsEvent(customerId: null),
      );
      return;
    }

    final results = _allCustomers
        .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _searchResults = results;
      _showSuggestions = true;
    });
  }

  void _onCustomerTap(CustomerModel customer) {
    _searchController.text = customer.name;

    setState(() {
      _selectedCustomer = customer;
      _selectedCustomerController.text = customer.name;
      _showSuggestions = false;
    });

    context.read<TotalPanelBloc>().add(
      LoadPanelsEvent(customerId: customer.id.toString()),
    );
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
          context.go('/home');
        },
      ),
      body: AppBackground(
        child: SafeArea(
          child: BlocBuilder<TotalPanelBloc, TotalPanelState>(
            builder: (context, state) {
              final isLoading = state.status == TotalPanelStatus.loading;

              if (state.status == TotalPanelStatus.failure) {
                return Center(child: Text(state.message));
              }

              /// FILTER ONLY (NO PAGINATION)
              final filtered = state.panels.where((panel) {
                final q = state.searchQuery.toLowerCase();
                return panel.serialNumber.toLowerCase().contains(q);
              }).toList();

              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: s(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: s(20)),

                              /// SEARCH BOX
                              PanelIdSearchBox(
                                scale: scale,
                                controller: _searchController,
                                onChanged: _onSearch,
                              ),

                              /// SUGGESTIONS
                              if (_showSuggestions && _searchResults.isNotEmpty)
                                Container(
                                  margin: EdgeInsets.only(top: s(10)),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.95),
                                    borderRadius: BorderRadius.circular(s(12)),
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: _searchResults.length,
                                    itemBuilder: (context, index) {
                                      final customer = _searchResults[index];

                                      return ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: s(12),
                                        ),
                                        title: Text(
                                          customer.name,
                                          style: GoogleFonts.poppins(
                                            fontSize: s(15),
                                            fontWeight: FontWeight.w500,
                                            color: ColorPalette.bottomtext,
                                          ),
                                        ),
                                        subtitle: Text(
                                          customer.phone ?? "",
                                          style: GoogleFonts.poppins(
                                            fontSize: s(12),
                                            color: Colors.grey,
                                          ),
                                        ),
                                        onTap: () => _onCustomerTap(customer),
                                      );
                                    },
                                  ),
                                ),

                              SizedBox(height: s(16)),

                              /// SELECTED CUSTOMER
                              if (_selectedCustomer != null)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Customer Name",
                                      style: GoogleFonts.poppins(
                                        fontSize: s(20),
                                        fontWeight: FontWeight.w600,
                                        color: ColorPalette.bottomtext,
                                      ),
                                    ),
                                    SizedBox(height: s(10)),
                                    Container(
                                      height: s(50),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: ColorPalette.whitetext
                                            .withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(
                                          s(10),
                                        ),
                                        border: Border.all(
                                          width: s(1),
                                          color: ColorPalette.whitetext,
                                        ),
                                      ),
                                      child: Center(
                                        child: TextField(
                                          readOnly: true,
                                          textAlign: TextAlign
                                              .left,
                                          controller: TextEditingController(
                                            text: _selectedCustomer!.name,
                                          ),
                                          style: GoogleFonts.poppins(
                                            fontSize: s(16),
                                            fontWeight: FontWeight.w500,
                                            color: ColorPalette.textfiledin
                                                .withValues(alpha: .80),
                                          ),
                                          decoration: InputDecoration(
                                            isCollapsed: true,
                                            border: InputBorder.none,
                                            hintText: "Customer Name",
                                            hintStyle: GoogleFonts.lato(
                                              fontSize: s(16),
                                              fontWeight: FontWeight.w400,
                                              color: ColorPalette.textfiled
                                                  .withValues(alpha: .80),
                                            ),
                                            contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(height: s(16)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Panels",
                                    style: GoogleFonts.poppins(
                                      fontSize: s(20),
                                      fontWeight: FontWeight.w600,
                                      color: ColorPalette.bottomtext,
                                    ),
                                  ),
                                  Text(
                                    "TotalPanels (${state.panels.length})",
                                    style: GoogleFonts.lato(
                                      fontSize: s(16),
                                      fontWeight: FontWeight.w600,
                                      color: ColorPalette.bottomtext,
                                    ),
                                  ),
                                ],
                              ),

                              /// PANEL LIST (NO PAGINATION)
                              filtered.isEmpty
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.symmetric(
                                        vertical: s(20),
                                      ),
                                      itemCount: filtered.length,
                                      itemBuilder: (context, index) {
                                        final panel = filtered[index];

                                        return PanelItemList(
                                          panel: panel,
                                          name: panel.serialNumber,
                                          isFirst: index == 0,
                                          isLast: index == filtered.length - 1,
                                          onTap: () {},
                                        );
                                      },
                                    ),

                              SizedBox(height: s(30)),
                            ],
                          ),
                        ),
                      ),
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
        ),
      ),
    );
  }
}
