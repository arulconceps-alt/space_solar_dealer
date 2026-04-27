import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/customer_detail/view/custmer_details_screen.dart';
import 'package:space_solar_dealer/src/customer_list/bloc/customer_list_bloc.dart';
import 'package:space_solar_dealer/src/customer_list/bloc/customer_list_state.dart';
import 'package:space_solar_dealer/src/customer_list/view/widget/customer_item.dart';
import 'package:space_solar_dealer/src/customer_list/view/widget/search_box.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CustomerListBloc>().add(LoadCustomers());
    });
  }


  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    double s(double v) => v * scale;

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: _buildFAB(s),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
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
                      color: ColorPalette.textfiledin.withValues(alpha: .80),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: s(20)),

            /// SEARCH
            Padding(
              padding: EdgeInsets.symmetric(horizontal: s(20)),
              child: SearchBox(
                scale: scale,
                controller: _searchController,
                onChanged: (value) {
                  context.read<CustomerListBloc>().add(SearchCustomers(value));
                },
              ),
            ),

            SizedBox(height: s(20)),

            /// LIST (IMPORTANT: USE EXPANDED)
            Expanded(
              child: BlocBuilder<CustomerListBloc, CustomerListState>(
                builder: (context, state) {
                  return Stack(
                    children: [

                      /// ✅ MAIN CONTENT (always visible)
                      if (state.filteredCustomers.isNotEmpty)
                        ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: s(20)),
                          itemCount: state.filteredCustomers.length,
                          itemBuilder: (context, index) {
                            final customer = state.filteredCustomers[index];
                            return CustomerItem(
                              customer: customer,
                              isFirst: index == 0,
                              isLast: index == state.filteredCustomers.length - 1,
                              onTap: () {
                                context.push('/customer_detail', extra: customer);
                              },
                            );
                          },
                        )
                      else if (state.status == CustomerListStatus.success)
                        const Center(child: Text("No customers found")),

                      /// ✅ LOADER OVERLAY
                      if (state.status == CustomerListStatus.loading)
                        Container(
                          color: Colors.black.withOpacity(0.2), // dim background
                          child: const Center(
                            child: CircularProgressIndicator(color: ColorPalette.background,),
                          ),
                        ),

                      /// ❌ ERROR
                      if (state.status == CustomerListStatus.failure)
                        Center(child: Text(state.message)),
                    ],
                  );
                },
              ),
            ),

            SizedBox(height: s(10)),
          ],
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: s(10),
            offset: Offset(0, s(4)),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          context.push('/customer_register');
        },
        borderRadius: BorderRadius.circular(s(10)),

        child: Padding(
          padding: EdgeInsets.only(
            left: s(13),
            right: s(19),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// ICON
              Image.asset(
                "assets/images/customer/add_icon.png",
                color:  ColorPalette.whitetext,
                height: s(22),
                width: s(22),
              ),

              SizedBox(width: s(12)),

              /// TEXT
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
      ),
    );
  }
}