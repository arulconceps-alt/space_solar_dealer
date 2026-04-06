import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/customer_detail/view/custmer_details_screen.dart';
import 'package:space_solar_dealer/src/customer_list/widget/customer_item.dart';
import 'package:space_solar_dealer/src/customer_list/widget/search_box.dart';


class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  final TextEditingController _searchController = TextEditingController();

  final List<String> allCustomers = [
    "Baranee", "Mani", "Rahul", "Mohan", "Rahul", "Mani", "Mani"
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
      body: SafeArea(
        child: SingleChildScrollView(  
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
                        color:  ColorPalette.bottomtext,
                      ),
                    ),
                    SizedBox(height: s(4)),
                    Text(
                      "Customer Information",
                      style: GoogleFonts.lato(
                        fontSize: s(14),
                        fontWeight: FontWeight.w400,
                        color:  ColorPalette.textfiledin.withValues(alpha: .80),
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
                  onChanged: _searchCustomer,
                ),
              ),
      
              SizedBox(height: s(33)),
      
              ListView.builder(
                shrinkWrap: true, 
                physics: const NeverScrollableScrollPhysics(), 
                padding: EdgeInsets.symmetric(horizontal: s(20)),
                itemCount: filteredCustomers.length,
                itemBuilder: (context, index) {
                  final customer = filteredCustomers[index];
                  return CustomerItem(
                    name: customer,
                    isFirst: index == 0,
                    isLast: index == filteredCustomers.length - 1,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CustomerDetailsScreen(name: customer),
                        ),
                      );
                    },
                  );
                },
              ),
      
              SizedBox(height: s(80)), 
            ],
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