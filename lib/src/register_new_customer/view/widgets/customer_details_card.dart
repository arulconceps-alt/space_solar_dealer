import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/register_new_customer/bloc/new_register_bloc.dart';
import 'package:space_solar_dealer/src/register_new_customer/view/widgets/phone_search_box.dart';

class CustomerDetailsCard extends StatefulWidget {
  final double scale;
  final VoidCallback onClearPanels;
  final Function(List<String>) onPanelsLoaded;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController stateController;
  final TextEditingController districtController;
  final TextEditingController pincodeController;
  final TextEditingController addressController;

  const CustomerDetailsCard({
    super.key,
    required this.scale,
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.stateController,
    required this.districtController,
    required this.pincodeController,
    required this.addressController,
    required this.onClearPanels,
    required this.onPanelsLoaded,
  });

  @override
  State<CustomerDetailsCard> createState() => CustomerDetailsCardState();
}

class CustomerDetailsCardState extends State<CustomerDetailsCard> {
  String selectedCustomerType = "New Customer";
  late TextEditingController _searchController;
  bool isUserSelected = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onUserSelected(Map<String, dynamic> customer) {
    setState(() {
      isUserSelected = true;
      _searchController.clear();

      widget.nameController.text = customer["name"] ?? "";
      widget.phoneController.text = customer["phone"] ?? "";
      widget.emailController.text = customer["email"] ?? "";
      widget.addressController.text = customer["address"] ?? "";

      widget.onPanelsLoaded(
        (customer["panels"] as List?)?.map((e) => e.toString()).toList() ?? [],
      );
    });
  }

  void resetToNewCustomer() {
    setState(() {
      selectedCustomerType = "New Customer";
      isUserSelected = false;
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * widget.scale;
    final isDisabled = selectedCustomerType == "Existing Customer" && isUserSelected;

    return BlocBuilder<NewRegisterBloc, NewRegisterState>(
      builder: (context, state) {
        return Container(
          width: s(400),
          padding: EdgeInsets.all(s(20)),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(s(20)),
            border: Border.all(color: Colors.white),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Customer Details",
                style: GoogleFonts.poppins(
                  fontSize: s(18),
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF2D2D2D),
                ),
              ),
              SizedBox(height: s(24)),
              Row(
                children: [
                  _buildOption("New Customer", widget.scale),
                  SizedBox(width: s(38)),
                  _buildOption("Existing Customer", widget.scale),
                ],
              ),
              SizedBox(height: s(26)),
              if (selectedCustomerType == "Existing Customer") ...[
                PhoneSearchBox(
                  scale: widget.scale,
                  controller: _searchController,
                  onSearch: (val) {
                    context.read<NewRegisterBloc>().add(SearchCustomer(val));
                  },
                  suggestions: state.searchResults, // ✅ now full map list
                  onSelected: (customer) {
                    _onUserSelected(customer);
                  },
                ),
                SizedBox(height: s(24)),
              ],
              _buildInputField("Customer Name*", "Customer Name", widget.scale,
                  controller: widget.nameController, enabled: !isDisabled),
              SizedBox(height: s(16)),
              _buildInputField("Phone Number*", "Phone Number", widget.scale,
                  controller: widget.phoneController, enabled: !isDisabled),
              SizedBox(height: s(16)),
              _buildInputField("Email*", "Email", widget.scale,
                  controller: widget.emailController, enabled: !isDisabled),
              SizedBox(height: s(16)),

              // State Dropdown
              _buildDropdownField(
                "State*",
                "Select State",
                widget.scale,
                value: state.selectedState,
                items: state.states.map((e) => e["name"].toString()).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      final selected = state.states.firstWhere((e) => e["name"] == val);

                      context.read<NewRegisterBloc>().add(
                        SelectState(selected["name"], selected["id"]),
                      );
                    }
                  },
              ),
              SizedBox(height: s(16)),

              // District Dropdown
              _buildDropdownField(
                "District*",
                "Select District",
                widget.scale,
                value: state.selectedDistrict,
                items: state.districts.map((e) => e["name"].toString()).toList(),
                enabled: state.selectedState != null,

                onChanged: (val) {
                  final selected = state.districts.firstWhere((e) => e["name"] == val);
                  context.read<NewRegisterBloc>().add(
                    SelectDistrict(selected["name"], selected["id"]),
                  );
                },
              ),
              SizedBox(height: s(16)),
              _buildDropdownField(
                "Pincode*",
                "Select Pincode",
                widget.scale,
                value: state.selectedPincode,
                items: state.pincodesList
                    .map((e) => e["code"].toString())
                    .toSet()
                    .toList(),
                enabled: state.selectedDistrict != null,
                onChanged: (val) {
                  if (val != null) {
                    final selected = state.pincodesList.firstWhere(
                          (e) => e["code"].toString() == val,
                    );

                    context.read<NewRegisterBloc>().add(
                      SelectPincode(
                        id: selected["id"],
                        code: selected["code"].toString(),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: s(16)),
              _buildInputField("Address*", "Enter full installation address", widget.scale,
                  isAddress: true, controller: widget.addressController, enabled: !isDisabled),
            ],
          ),
        );
      },
    );
  }

  // Helper methods...
  Widget _buildInputField(String label, String hint, double scale,
      {bool isAddress = false, TextEditingController? controller, bool enabled = true}) {
    double s(double v) => v * scale;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.lato(fontSize: s(16), fontWeight: FontWeight.w600, color: ColorPalette.bottomtext)),
        SizedBox(height: s(14)),
        Container(
          height: isAddress ? s(74) : s(50),
          decoration: BoxDecoration(
            color: enabled ? Colors.white.withOpacity(0.5) : Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(s(10)),
            border: Border.all(color: Colors.white),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: s(16)),
            child: TextField(
              controller: controller,
              enabled: enabled,
              maxLines: isAddress ? 3 : 1,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                hintStyle: GoogleFonts.lato(color: const Color(0xCC484848).withOpacity(0.8), fontSize: s(16)),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(
      String label,
      String hint,
      double scale, {
        required String? value,
        required List<String> items,
        required ValueChanged<String?> onChanged,
        bool enabled = true,
      }) {
    double s(double v) => v * scale;

    // ✅ Remove duplicates safely
    final uniqueItems = items.toSet().toList();

    // ✅ Ensure selected value exists in items
    final safeValue =
    (value != null && uniqueItems.contains(value)) ? value : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.lato(
            fontSize: s(16),
            fontWeight: FontWeight.w600,
            color: ColorPalette.bottomtext,
          ),
        ),
        SizedBox(height: s(14)),
        Container(
          height: s(50),
          padding: EdgeInsets.symmetric(horizontal: s(16)),
          decoration: BoxDecoration(
            color: enabled
                ? Colors.white.withOpacity(0.5)
                : Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(s(10)),
            border: Border.all(color: Colors.white),
          ),
          child: DropdownButtonFormField<String>(
            value: safeValue, // ✅ FIXED VALUE
            isExpanded: true, // ✅ prevents overflow
            items: uniqueItems
                .map(
                  (e) => DropdownMenuItem<String>(
                value: e,
                child: Text(
                  e,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
                .toList(),
            onChanged: enabled ? onChanged : null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              hintStyle: GoogleFonts.lato(
                color: const Color(0xCC484848).withOpacity(0.8),
                fontSize: s(16),
              ),
            ),
            dropdownColor: Colors.white, // ✅ better UI
            icon: const Icon(Icons.keyboard_arrow_down),
          ),
        ),
      ],
    );
  }

  Widget _buildOption(String label, double scale) {
    double s(double v) => v * scale;
    bool isSelected = selectedCustomerType == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCustomerType = label;
          if (label == "New Customer") {
            isUserSelected = false;
            widget.nameController.clear();
            widget.phoneController.clear();
            widget.emailController.clear();
            widget.addressController.clear();
            widget.onClearPanels();
          }
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: isSelected ? const Color(0xFF26A7DF) : Colors.grey,
            size: s(20),
          ),
          SizedBox(width: s(8)),
          Text(label, style: GoogleFonts.lato(fontSize: s(16), fontWeight: FontWeight.w600, color: ColorPalette.bottomtext)),
        ],
      ),
    );
  }
}