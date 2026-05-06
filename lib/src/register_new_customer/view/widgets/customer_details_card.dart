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
  Map<String, dynamic>? selectedCustomerData;
  
  // Focus nodes for dropdown text fields
  final FocusNode _stateFocusNode = FocusNode();
  final FocusNode _districtFocusNode = FocusNode();
  final FocusNode _pincodeFocusNode = FocusNode();
  
  // Controllers for dropdown text fields
  late TextEditingController _stateTextController;
  late TextEditingController _districtTextController;
  late TextEditingController _pincodeTextController;
  
  // Track if suggestions should be shown
  bool _showStateSuggestions = false;
  bool _showDistrictSuggestions = false;
  bool _showPincodeSuggestions = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _stateTextController = TextEditingController();
    _districtTextController = TextEditingController();
    _pincodeTextController = TextEditingController();
    
    context.read<NewRegisterBloc>().add(LoadLocationData());
    _stateFocusNode.addListener(() {
      setState(() {
        _showStateSuggestions = _stateFocusNode.hasFocus;
      });
    });
    _districtFocusNode.addListener(() {
      setState(() {
        _showDistrictSuggestions = _districtFocusNode.hasFocus;
      });
    });
    _pincodeFocusNode.addListener(() {
      setState(() {
        _showPincodeSuggestions = _pincodeFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _stateTextController.dispose();
    _districtTextController.dispose();
    _pincodeTextController.dispose();
    _stateFocusNode.dispose();
    _districtFocusNode.dispose();
    _pincodeFocusNode.dispose();
    super.dispose();
  }

  Future<void> _onUserSelected(Map<String, dynamic> customer) async {
    final bloc = context.read<NewRegisterBloc>();

    setState(() {
      isUserSelected = true;
      _searchController.clear();

      widget.nameController.text = customer["name"] ?? "";
      widget.phoneController.text =
          (customer["phone"] ?? "").replaceAll("+91", "");
      widget.emailController.text = customer["email"] ?? "";
      widget.addressController.text = customer["addressLine1"] ?? "";
    });

    bloc.add(
      SelectExistingCustomer(
        id: customer["id"].toString(),
        stateId: customer["stateId"],
        districtId: customer["districtId"],
        pincodeId: customer["pincodeId"],
      ),
    );

    final orders = customer["orders"] ?? [];
    final Set<String> existingPanels = {};

    for (var order in orders) {
      for (var item in (order["items"] ?? [])) {
        final serial = item["serialNumber"]?.toString();
        if (serial != null && serial.isNotEmpty) {
          existingPanels.add(serial);
        }
      }
    }

    widget.onPanelsLoaded(existingPanels.toList());
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

      return BlocListener<NewRegisterBloc, NewRegisterState>(
  listener: (context, state) {
    print("👂 BlocListener Triggered");

    if (state.selectedState != null) {
      print("✅ UI State Updated: ${state.selectedState}");
      _stateTextController.text = state.selectedState!;
    }

    if (state.selectedDistrict != null) {
      print("✅ UI District Updated: ${state.selectedDistrict}");
      _districtTextController.text = state.selectedDistrict!;
    }

    if (state.selectedPincode != null) {
      print("✅ UI Pincode Updated: ${state.selectedPincode}");
      _pincodeTextController.text = state.selectedPincode!;
    }
  },
  child: BlocBuilder<NewRegisterBloc, NewRegisterState>(
    builder: (context, state) {

      return Container(
        width: s(400),
        padding: EdgeInsets.all(s(20)),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(s(20)),
          border: Border.all(color: Colors.white),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                  _buildOption("Register Panels", widget.scale),
                ],
              ),
              SizedBox(height: s(26)),

              if (selectedCustomerType == "Register Panels") ...[
                PhoneSearchBox(
                  scale: widget.scale,
                  controller: _searchController,
                  onSearch: (val) {
                    context.read<NewRegisterBloc>().add(SearchCustomer(val));
                  },
                  suggestions: state.searchResults,
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
                  controller: widget.emailController),
              SizedBox(height: s(16)),

              _buildSearchableTextField(
                "State*",
                "Select State",
                widget.scale,
                controller: _stateTextController,
                focusNode: _stateFocusNode,
                suggestions:  state.states.map((e) => e["name"].toString()).toList(),
                showSuggestions: _showStateSuggestions,
                onSuggestionSelected: (val) {
                  final selected = state.states.firstWhere((e) => e["name"] == val);
                  _stateTextController.text = val;
                  _stateFocusNode.unfocus();

                  setState(() {
                    _showStateSuggestions = false;
                  });

                  context.read<NewRegisterBloc>().add(
                        SelectState(selected["name"], selected["id"]),
                      );
                },
                enabled: !isDisabled,
              ),
              SizedBox(height: s(16)),

              _buildSearchableTextField(
                "District*",
                "Select District",
                widget.scale,
                controller: _districtTextController,
                focusNode: _districtFocusNode,
                suggestions: state.districts
                    .map((e) => e["name"].toString())
                    .toList(),
                showSuggestions: _showDistrictSuggestions,
                onSuggestionSelected: (val) {
                  final selected =
                      state.districts.firstWhere((e) => e["name"] == val);

                  _districtTextController.text = val;
                  _districtFocusNode.unfocus();

                  setState(() {
                    _showDistrictSuggestions = false;
                  });

                  context.read<NewRegisterBloc>().add(
                        SelectDistrict(selected["name"], selected["id"]),
                      );
                },
                enabled: !isDisabled && state.selectedState != null,
              ),
              SizedBox(height: s(16)),

              // ✅ PINCODE
              _buildSearchableTextField(
                "Pincode*",
                "Select Pincode",
                widget.scale,
                controller: _pincodeTextController,
                focusNode: _pincodeFocusNode,
                suggestions: state.pincodesList
                    .map((e) => e["code"].toString())
                    .toSet()
                    .toList(),
                showSuggestions: _showPincodeSuggestions,
                onSuggestionSelected: (val) {
                  final selected = state.pincodesList.firstWhere(
                    (e) => e["code"].toString() == val,
                  );

                  _pincodeTextController.text = val;
                  _pincodeFocusNode.unfocus();

                  setState(() {
                    _showPincodeSuggestions = false;
                  });

                  context.read<NewRegisterBloc>().add(
                        SelectPincode(
                          id: selected["id"],
                          code: selected["code"].toString(),
                        ),
                      );
                },
                enabled: !isDisabled && state.selectedDistrict != null,
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
            ],
          ),
        ),
      );
    },
  ),
);
  }

  Widget _buildSearchableTextField(
    String label,
    String hint,
    double scale, {
    required TextEditingController controller,
    required FocusNode focusNode,
    required List<String> suggestions,
    required bool showSuggestions,
    required Function(String) onSuggestionSelected,
    bool enabled = true,
  }) {
    double s(double v) => v * scale;
    
    // Filter suggestions based on current text
    final filteredSuggestions = controller.text.isEmpty 
        ? suggestions 
        : suggestions.where((item) => 
            item.toLowerCase().contains(controller.text.toLowerCase())
          ).toList();
    
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
        SizedBox(height: s(12)),
        Container(
          height: s(52),
          decoration: BoxDecoration(
            color: enabled
                ? Colors.white.withOpacity(0.5)
                : Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(s(10)),
            border: Border.all(color: Colors.white),
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: s(14)),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  enabled: enabled,
                  style: GoogleFonts.lato(
                    fontSize: s(16),
                    color: ColorPalette.bottomtext,
                  ),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: GoogleFonts.lato(
                      fontSize: s(16),
                      color: const Color(0x66484848),
                    ),
                  ),
                  onTap: () {
                    if (enabled && suggestions.isNotEmpty) {
                      focusNode.requestFocus();
                    }
                  },
                ),
              ),
              if (suggestions.isNotEmpty)
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                  size: s(24),
                ),
            ],
          ),
        ),
        // Suggestions dropdown that appears below
        if (showSuggestions && filteredSuggestions.isNotEmpty && enabled)
          Container(
            margin: EdgeInsets.only(top: s(4)),
            constraints: BoxConstraints(
              maxHeight: s(200),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(s(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: s(8),
                  offset: Offset(0, s(2)),
                ),
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredSuggestions.length,
              itemBuilder: (context, index) {
                final suggestion = filteredSuggestions[index];
                return GestureDetector(
                  onTap: () {
                    onSuggestionSelected(suggestion);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: s(14),
                      vertical: s(12),
                    ),
                    // decoration: BoxDecoration(
                    //   border: Border(
                    //     bottom: BorderSide(
                    //       color: Colors.grey.withOpacity(0.2),
                    //     ),
                    //   ),
                    // ),
                    child: Text(
                      suggestion,
                      style: GoogleFonts.lato(
                        fontSize: s(14),
                        color: ColorPalette.bottomtext,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildInputField(
      String label,
      String hint,
      double scale, {
        bool isAddress = false,
        TextEditingController? controller,
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
        SizedBox(height: s(12)),

        Container(
          height: isAddress ? s(110) : s(52),
          decoration: BoxDecoration(
            color: enabled
                ? Colors.white.withOpacity(0.5)
                : Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(s(10)),
            border: Border.all(color: Colors.white),
          ),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: s(14)),

          child: TextField(
            controller: controller,
            enabled: enabled,
            maxLines: isAddress ? 4 : 1,
            textAlignVertical: TextAlignVertical.center,
            style: GoogleFonts.lato(
              fontSize: s(16),
              color: ColorPalette.bottomtext,
            ),
            decoration: InputDecoration(
              isCollapsed: true,
              border: InputBorder.none,
              hintText: hint,
              hintStyle: GoogleFonts.lato(
                fontSize: s(16),
                color: const Color(0x66484848),
              ),
            ),
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
        if (selectedCustomerType == label) return;

        setState(() {
          selectedCustomerType = label;
          isUserSelected = false;
          widget.nameController.clear();
          widget.phoneController.clear();
          widget.emailController.clear();
          widget.addressController.clear();
          _searchController.clear();
          _stateTextController.clear();
          _districtTextController.clear();
          _pincodeTextController.clear();
          _showStateSuggestions = false;
          _showDistrictSuggestions = false;
          _showPincodeSuggestions = false;
        });

        context.read<NewRegisterBloc>().add(ResetRegisterState());
        if (label == "New Customer") {
          widget.onClearPanels();
        }
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