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
    required this.onPanelsLoaded,// ✅ ADD THIS
  });

  @override
  State<CustomerDetailsCard> createState() => CustomerDetailsCardState();
}
class CustomerDetailsCardState extends State<CustomerDetailsCard> {
  String selectedCustomerType = "New Customer";
  late TextEditingController _searchController;
  bool isUserSelected = false;
  List<Map<String, dynamic>> _selectedUserObjects = [];
  List<String> _suggestions = [];
  String? _selectedUserDetail;

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
      isUserSelected = true; // ✅ ENABLE LOCK

      _suggestions = [];
      _searchController.clear();

      widget.nameController.text = customer["name"] ?? "";
      widget.phoneController.text = customer["phone"] ?? "";
      widget.emailController.text = customer["email"] ?? "";
      widget.pincodeController.text = customer["pincode"] ?? "";
      widget.addressController.text = customer["address"] ?? "";

      final String apiState = customer["state"] ?? "";
      final String apiDistrict = customer["district"] ?? "";

      final panelsFromApi = (customer["panels"] as List?)
          ?.map((e) => e.toString())
          .toList() ?? [];

      widget.onPanelsLoaded(panelsFromApi);

      if (apiState.isNotEmpty) {
        context.read<NewRegisterBloc>().add(SelectState(apiState));
        Future.delayed(const Duration(milliseconds: 100), () {
          if (apiDistrict.isNotEmpty) {
            context.read<NewRegisterBloc>().add(SelectDistrict(apiDistrict));
          }
        });
      }
    });
  }
  void resetToNewCustomer() {
    setState(() {
      selectedCustomerType = "New Customer";
      isUserSelected = false;
      _searchController.clear();
      _suggestions = [];
      _selectedUserDetail = null;
    });
  }
  @override
  Widget build(BuildContext context) {
    double s(double v) => v * widget.scale;
    final isDisabled =
        selectedCustomerType == "Existing Customer" && isUserSelected;
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

          // 3. Search and Detail Box Logic
          if (selectedCustomerType == "Existing Customer") ...[
            PhoneSearchBox(
              scale: widget.scale,
              controller: _searchController,
              onSearch: (val) {
                context.read<NewRegisterBloc>().add(SearchCustomer(val));
              },

              // ✅ FIX HERE
              suggestions: state.searchResults
                  .map((e) => "${e['name']} - ${e['phone']}")
                  .toList(),

              onSelected: (text) {
                final customer = state.searchResults.firstWhere(
                      (e) => "${e['name']} - ${e['phone']}" == text,
                );

                _onUserSelected(customer);
              },
            ),
            SizedBox(height: s(24)),
          ],
          _buildInputField(
            "Customer Name*",
            "Customer Name",
            widget.scale,
            controller: widget.nameController,
            enabled: !isDisabled,
          ),
          SizedBox(height: s(16)),
          _buildInputField(
            "Phone Number*",
            "Phone Number",
            widget.scale,
            controller: widget.phoneController,
            enabled: !isDisabled,
          ),
          SizedBox(height: s(16)),
          _buildInputField(
            "Email*",
            "Email",
            widget.scale,
            controller: widget.emailController,
            enabled: !isDisabled,
          ),
         /* _buildInputField("Customer Name*", "Customer Name", widget.scale, controller: widget.nameController),
          SizedBox(height: s(16)),
          _buildInputField("Phone Number*", "Phone Number", widget.scale, controller: widget.phoneController),
          SizedBox(height: s(16)),
          _buildInputField("Email*", "Email", widget.scale, controller: widget.emailController),*/
          SizedBox(height: s(16)),
          _buildDropdownField(
            "State*",
            "Select State",
            widget.scale,
            value: state.selectedState,
            items: state.states,
            onChanged: (val) {
              if (val != null) {
                context.read<NewRegisterBloc>().add(SelectState(val));
              }
            },
            enabled: !isDisabled, // ✅
          ),
          SizedBox(height: s(16)),
          _buildDropdownField(
            "District*",
            "Select District",
            widget.scale,
            value: state.selectedDistrict,
            items: state.districts,
            onChanged: (val) {
              if (val != null) {
                context.read<NewRegisterBloc>().add(SelectDistrict(val));
              }
            },
            enabled: !isDisabled, // ✅
          ),
      //    _buildInputField("District*", "District", widget.scale, controller: widget.districtController),
          SizedBox(height: s(16)),
          _buildInputField(
            "Pincode*",
            "Pincode",
            widget.scale,
            controller: widget.pincodeController,
            enabled: !isDisabled,
          ),
          SizedBox(height: s(16)),
          _buildInputField(
            "Address*",
            "Enter full installation address",
            widget.scale,
            isAddress: true,
            controller: widget.addressController,
            enabled: !isDisabled,
          ),
         /* _buildInputField("Pincode*", "Pincode", widget.scale, controller: widget.pincodeController),
          SizedBox(height: s(16)),
          _buildInputField(
            "Address*",
            "Enter full installation address",
            widget.scale,
            isAddress: true,
            controller: widget.addressController,
          ),*/
        ],
      ),
    );});
  }

  Widget _buildInputField(
      String label,
      String hint,
      double scale, {
        bool isAddress = false,
        TextEditingController? controller,
        bool enabled = true, // ✅ ADD
      }) {
    double s(double v) => v * scale;

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
        _buildSimpleInput(
          hint,
          scale,
          isAddress: isAddress,
          controller: controller,
          enabled: enabled, // ✅ PASS
        ),
      ],
    );
  }

  Widget _buildSimpleInput(
      String hint,
      double scale, {
        bool isAddress = false,
        TextEditingController? controller,
        bool enabled = true, // ✅ ADD
      }) {
    double s(double v) => v * scale;

    return Container(
      height: isAddress ? s(74) : s(50),
      decoration: BoxDecoration(
        color: enabled
            ? Colors.white.withOpacity(0.5)
            : Colors.grey.withOpacity(0.3), // ✅ disabled color
        borderRadius: BorderRadius.circular(s(10)),
        border: Border.all(color: Colors.white),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: s(16)),
        child: TextField(
          controller: controller,
          enabled: enabled, // ✅ IMPORTANT
          maxLines: isAddress ? 3 : 1,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
          ),
        ),
      ),
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
            _searchController.clear();
            _suggestions = [];
            _selectedUserDetail = null;
            // ✅ clear auto-filled fields
            widget.nameController.clear();
            widget.phoneController.clear();
            widget.emailController.clear();
            widget.stateController.clear();
            widget.districtController.clear();
            widget.pincodeController.clear();
            widget.addressController.clear();
            widget.onClearPanels();
          }
          if (label == "Existing Customer") {
            isUserSelected = false;
           widget.onClearPanels();
          }
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: s(20),
            height: s(20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? const Color(0xFF26A7DF) : const Color(0xFF4A4A4A),
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
              child: Container(
                width: s(10),
                height: s(10),
                decoration: const BoxDecoration(
                  color: Color(0xFF26A7DF),
                  shape: BoxShape.circle,
                ),
              ),
            )
                : null,
          ),
          SizedBox(width: s(8)),
          Text(
            label,
            style: GoogleFonts.lato(
              fontSize: s(16),
              fontWeight: FontWeight.w600,
              color: ColorPalette.bottomtext,
            ),
          ),
        ],
      ),
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
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: s(16)),
          decoration: BoxDecoration(
            color: enabled
                ? Colors.white.withOpacity(0.5)
                : Colors.grey.withOpacity(0.3), // ✅ disabled color
            borderRadius: BorderRadius.circular(s(10)),
            border: Border.all(color: Colors.white),
          ),
          child: DropdownButtonFormField<String>(
            value: (value != null && items.contains(value)) ? value : null,
            isExpanded: true,
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: const Color(0xFF484848),
              size: s(24),
            ),
            style: GoogleFonts.lato(
              fontSize: s(16),
              color: enabled
                  ? ColorPalette.bottomtext
                  : Colors.grey, // ✅ disabled text color
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
              hintText: hint,
            ),
            items: items.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e),
              );
            }).toList(),

            // 🔥 MAIN FIX
            onChanged: enabled ? onChanged : null,
          ),
        ),
      ],
    );
  }
}



