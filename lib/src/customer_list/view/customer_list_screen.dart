import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/widgets/common_app_bar.dart';
import 'package:space_solar_dealer/src/customer_list/bloc/customer_list_bloc.dart';
import 'package:space_solar_dealer/src/customer_list/bloc/customer_list_state.dart';
import 'package:space_solar_dealer/src/customer_list/view/widget/customer_item.dart';
import 'package:space_solar_dealer/src/customer_list/view/widget/search_box.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';

class CustomerList extends StatefulWidget {
  final bool showAppBar;

  const CustomerList({super.key, this.showAppBar = false});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final bloc = context.read<CustomerListBloc>();
    bloc.add(const LoadCustomers(page: 1));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        final state = bloc.state;

        if (!state.isLoadingMore && !state.hasReachedMax) {
          bloc.add(LoadCustomers(page: state.page + 1));
        }
      }
    });
  }

  @override
  void didPopNext() {
    context.read<CustomerListBloc>().add(const LoadCustomers(page: 1));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    double s(double v) => v * scale;

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: widget.showAppBar
            ? PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: CommonAppBar(
                  scale: scale,
                  showBack: true,
                  showNotification: true,
                  onBackTap: () {
                    context.go('/home');
                  },
                ),
              )
            : null,
        floatingActionButton: _buildFAB(s),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        // ✅ FIX: Single scroll container for HEADER + LIST
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<CustomerListBloc>().add(
                    const LoadCustomers(page: 1),
                  );
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: s(24)),

                  /// HEADER
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: s(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Customer List",
                          style: GoogleFonts.poppins(
                            fontSize: s(20),
                            fontWeight: FontWeight.w600,
                            color: ColorPalette.bottomtext,
                          ),
                        ),
                        SizedBox(height: s(4)),
                        Text(
                          "Customer Information",
                          style: GoogleFonts.lato(
                            fontSize: s(14),
                            color:
                                ColorPalette.textfiledin.withValues(alpha: .80),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: s(20)),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: s(20)),
                    child: SearchBox(
                      scale: scale,
                      controller: _searchController,
                      onChanged: (value) {
                        context
                            .read<CustomerListBloc>()
                            .add(SearchCustomers(value));
                      },
                    ),
                  ),

                  SizedBox(height: s(20)),

                  /// LIST
                  BlocBuilder<CustomerListBloc, CustomerListState>(
                    builder: (context, state) {
                      if (state.status == CustomerListStatus.failure) {
                        return Center(child: Text(state.message));
                      }

                      if (state.filteredCustomers.isEmpty &&
                          state.status == CustomerListStatus.success) {
                        return const Center(child: Text("No customers found"));
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: s(20)),
                        itemCount: state.filteredCustomers.length,
                        itemBuilder: (context, index) {
                          final customer = state.filteredCustomers[index];
                          return CustomerItem(
                            customer: customer,
                            isFirst: index == 0,
                            isLast:
                                index == state.filteredCustomers.length - 1,
                            onTap: () {
                              context.push(
                                '/customer_detail',
                                extra: customer,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),

                  BlocBuilder<CustomerListBloc, CustomerListState>(
                    builder: (context, state) {
                      if (state.isLoadingMore) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF26A7DF),
                              strokeWidth: 3,
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),

                  SizedBox(height: s(100)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFAB(double Function(double) s) {
    return Container(
      width: s(192),
      height: s(50),
      decoration: BoxDecoration(
        color: const Color(0xFF26A7DF),
        borderRadius: BorderRadius.circular(s(10)),
      ),
      child: InkWell(
        onTap: () {
          context.push('/customer_register').then((_) {
            context
                .read<CustomerListBloc>()
                .add(const LoadCustomers(page: 1));
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/customer/add_icon.png",
              color: ColorPalette.whitetext,
              height: s(22),
              width: s(22),
            ),
            SizedBox(width: s(12)),
            Text(
              "New Customer",
              style: GoogleFonts.poppins(
                fontSize: s(16),
                fontWeight: FontWeight.w500,
                color: ColorPalette.whitetext,
              ),
            ),
          ],
        ),
      ),
    );
  }
}