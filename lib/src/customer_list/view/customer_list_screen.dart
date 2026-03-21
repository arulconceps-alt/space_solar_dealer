import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/customer_detail/view/custmer_details_screen.dart';
import 'package:space_solar_dealer/src/customer_list/widget/customer_item.dart';
import 'package:space_solar_dealer/src/customer_list/widget/search_box.dart';
import 'package:space_solar_dealer/src/home/widgets/top_header_card.dart';

import 'package:space_solar_dealer/src/register_new_customer/widgets/register_blur_circle.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}
class _CustomerListState extends State<CustomerList> {
  final TextEditingController _searchController = TextEditingController();
  List<String> allCustomers = [
    "Baranee",
    "Mani",
    "Rahul",
    "Mohan",
    "Rahul",
    "Mani",
  ];

  List<String> filteredCustomers = [];

  @override
  void initState() {
    super.initState();
    filteredCustomers = allCustomers;
  }

  void _searchCustomer(String query) {
    final results = allCustomers.where((customer) {
      return customer.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredCustomers = results;
    });
  }
  void _addCustomer() {
    setState(() {
      allCustomers.add("New Customer ${allCustomers.length + 1}");
      filteredCustomers = allCustomers;
    });
  }
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    return Scaffold(
      backgroundColor: const Color(0xFFB5E2F4),
      body: Stack(
        children: [
          RegisterBlurCircle(left: -146, top: -201, size: 383, color: Colors.white, scale: scale, blur: 60),
          RegisterBlurCircle(left: 209, top: 94, size: 383, color: Colors.white.withOpacity(0.3), scale: scale, blur: 40),
          RegisterBlurCircle(left: -153, top: 575, size: 383, color: Colors.white.withOpacity(0.6), scale: scale, blur: 50),

          SafeArea(
            child: Column(
              children: [
                TopHeaderCard(
                  scale: scale,
                  notificationCount: "16",
                  onBackTap: null,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20 * scale),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24 * scale),

                        Text(
                          "Customer List",
                          style: TextStyle(
                            fontSize: 20 * scale,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF282828),
                          ),
                        ),

                        Text(
                          "Customer Information",
                          style: TextStyle(
                            fontSize: 14 * scale,
                            color: const Color(0xCC484848),
                          ),
                        ),

                        SizedBox(height: 16 * scale),

                        SearchBox(
                          scale: scale,
                          controller: _searchController,
                          onChanged: _searchCustomer,
                        ),

                        SizedBox(height: 20 * scale),

                        /// 🔥 ONLY LIST SCROLLS
                        Expanded(
                          child: ListView.builder(
                            itemCount: filteredCustomers.length,
                            itemBuilder: (context, index) {
                              final customerName = filteredCustomers[index];

                              return CustomerItem(
                                name: customerName,
                                isFirst: index == 0,
                                isLast: index == filteredCustomers.length - 1,

                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CustomerDetailsScreen(
                                        name: customerName, // ✅ PASS DATA
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
              ],
            ),
          ),

          // 3. FIXED "NEW CUSTOMER" BUTTON
          Positioned(
            right: 20 * scale,
            bottom: 20 * scale,
            child: GestureDetector(
              onTap: () {
                context.push('/customer_register');
              },
              child: Container(
                width: 192 * scale,
                height: 50 * scale,
                decoration: BoxDecoration(
                  color: const Color(0xFF26A7DF),
                  borderRadius: BorderRadius.circular(10 * scale),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10 * scale,
                      offset: Offset(0, 4 * scale),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline, color: Colors.white, size: 22 * scale),
                    SizedBox(width: 8 * scale),
                    Text(
                      "New Customer",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16 * scale,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}