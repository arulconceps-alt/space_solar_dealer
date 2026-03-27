import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/customer_detail/view/custmer_details_screen.dart';
import 'package:space_solar_dealer/src/customer_list/widget/customer_item.dart';
import 'package:space_solar_dealer/src/customer_list/widget/search_box.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';


class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> allCustomers = [
    "Baranee", "Mani", "Rahul", "Mohan", "Rahul", "Mani",
  ];

  List<String> filteredCustomers = [];

  @override
  void initState() {
    super.initState();
    filteredCustomers = allCustomers;
  }

  void _searchCustomer(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCustomers = allCustomers;
      } else {
        filteredCustomers = allCustomers
            .where((customer) =>
            customer.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
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
      body: AppBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: s(24)),

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
                        color: const Color(0xFF282828),
                      ),
                    ),

                    SizedBox(height: s(4)),

                    Text(
                      "Customer Information",
                      style: GoogleFonts.lato(
                        fontSize: s(14),
                        fontWeight: FontWeight.w400,
                        color: const Color(0xCC484848),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: s(20)),

              /// SEARCH BOX
              Padding(
                padding: EdgeInsets.symmetric(horizontal: s(20)),
                child: SearchBox(
                  scale: scale,
                  controller: _searchController,
                  onChanged: _searchCustomer,
                ),
              ),

              SizedBox(height: s(33)),

              /// LIST
              Expanded(
                child: filteredCustomers.isEmpty
                    ? Center(
                  child: Text(
                    "No customers found",
                    style: TextStyle(fontSize: s(14)),
                  ),
                )
                    : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: s(20)),
                  itemCount: filteredCustomers.length,
                  itemBuilder: (context, index) {
                    final customer = filteredCustomers[index];
                    return CustomerItem(
                      name: customer,
                      isFirst: index == 0,
                      isLast:
                      index == filteredCustomers.length - 1,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                CustomerDetailsScreen(
                                  name: customer,
                                ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ FIXED FAB (scaling applied correctly)
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

        /// ✅ FIXED ALIGNMENT
        child: Padding(
          padding: EdgeInsets.only(
            left: s(13),   // 👈 Figma exact
            right: s(19),  // 👈 Figma exact
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// ICON
              Image.asset(
                "assets/images/customer/add_icon.png",
                color: Colors.white,
                height: s(22),
                width: s(22),
              ),

              SizedBox(width: s(13)), // 👈 exact spacing

              /// TEXT
              Text(
                "New Customer",
                style: GoogleFonts.poppins(
                  fontSize: s(16),
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}