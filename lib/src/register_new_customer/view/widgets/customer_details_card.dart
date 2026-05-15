import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/bloc/alert/alert_state.dart';
import 'package:space_solar_dealer/src/common/widgets/custom_snackbar.dart';
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
  final Function(String) onCustomerTypeChanged;

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
    required this.onCustomerTypeChanged,
  });

  @override
  State<CustomerDetailsCard> createState() => CustomerDetailsCardState();
}

class CustomerDetailsCardState extends State<CustomerDetailsCard> {
  String selectedCustomerType = "New Customer";
  late TextEditingController _searchController;
  bool isUserSelected = false;
  Map<String, dynamic>? selectedCustomerData;

  // Store existing panels separately
  List<String> existingPanels = [];
  List<String> newPanels = [];
  List<String> get allPanels => [...existingPanels, ...newPanels];

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
  Timer? _debounce;

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
    _debounce?.cancel();
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

    final soldSerials = customer["soldSerials"] as List<dynamic>? ?? [];

    final Set<String> existingPanelSet = {};

    for (final item in soldSerials) {
      final map = item as Map<String, dynamic>;

      final serial = map["serialNumber"]?.toString();

      if (serial != null && serial.isNotEmpty) {
        existingPanelSet.add(serial);
      }
    }

    setState(() {
      isUserSelected = true;
      existingPanels = existingPanelSet.toList();
      newPanels = [];
      _searchController.clear();

      widget.nameController.text = customer["name"] ?? "";

      String phone = (customer["phone"] ?? "").toString();
      if (phone.startsWith("+91")) {
        phone = phone.substring(3);
      }
      widget.phoneController.text = phone;

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

    widget.onPanelsLoaded(existingPanelSet.toList());
  }

  void addNewPanel(String panelId) {
    setState(() {
      if (!newPanels.contains(panelId) && !existingPanels.contains(panelId)) {
        newPanels.add(panelId);
      }
    });
    widget.onPanelsLoaded([...existingPanels, ...newPanels]);
  }

  // Remove new panel
  void removeNewPanel(String panelId) {
    setState(() {
      newPanels.remove(panelId);
    });
    widget.onPanelsLoaded([...existingPanels, ...newPanels]);
  }

  List<String> getAllPanels() {
    return [...existingPanels, ...newPanels];
  }

  List<String> getNewPanelsOnly() {
    return List.from(newPanels);
  }

  void resetToNewCustomer() {
    setState(() {
      selectedCustomerType = "New Customer";
      isUserSelected = false;
      existingPanels = [];
      newPanels = [];
      _searchController.clear();
      widget.nameController.clear();
      widget.phoneController.clear();
      widget.emailController.clear();
      widget.addressController.clear();
      _stateTextController.clear();
      _districtTextController.clear();
      _pincodeTextController.clear();
    });

    // optional but important
    context.read<NewRegisterBloc>().add(ResetRegisterState());
    context.read<NewRegisterBloc>().add(LoadLocationData());

    widget.onClearPanels();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && selectedCustomerType == "New Customer") {
        _stateFocusNode.unfocus();
        _districtFocusNode.unfocus();
        _pincodeFocusNode.unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * widget.scale;
    final isDisabled =
        selectedCustomerType == "Register Panels" && isUserSelected;

    return BlocListener<NewRegisterBloc, NewRegisterState>(
      listener: (context, state) {
        if (state.selectedState != null) {
          _stateTextController.text = state.selectedState!;
        } else {
          _stateTextController.clear();
        }

        if (state.selectedDistrict != null) {
          _districtTextController.text = state.selectedDistrict!;
        } else {
          _districtTextController.clear();
        }

        if (state.selectedPincode != null) {
          _pincodeTextController.text = state.selectedPincode!;
        } else {
          _pincodeTextController.clear();
        }

        // SUCCESS
        if (state.status == NewRegisterStatus.success) {
          CustomSnackBar.show(
            context,
            AlertState(
              message: state.message,
              type: AlertType.success,
              timestamp: DateTime.now(),
            ),
          );
        }

        // FAILURE
        if (state.status == NewRegisterStatus.failure) {
          CustomSnackBar.show(
            context,
            AlertState(
              message: state.message,
              type: AlertType.failure,
              timestamp: DateTime.now(),
            ),
          );
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
                        if (_debounce?.isActive ?? false) {
                          _debounce!.cancel();
                        }

                        _debounce = Timer(
                          const Duration(milliseconds: 400),
                          () {
                            context.read<NewRegisterBloc>().add(
                              SearchCustomer(val),
                            );
                          },
                        );
                      },
                      suggestions: state.searchResults,
                      onSelected: (customer) {
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
                  ),
                  SizedBox(height: s(16)),

                  _buildSearchableTextField(
                    "State*",
                    "Select State",
                    widget.scale,
                    controller: _stateTextController,
                    focusNode: _stateFocusNode,
                    suggestions: (state.states).isEmpty
                        ? []
                        : state.states
                              .map((e) => e["name"].toString())
                              .toList(),
                    showSuggestions: _showStateSuggestions,
                    onSuggestionSelected: (val) {
                      final selected = state.states.firstWhere(
                        (e) => e["name"] == val,
                      );
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
                    suggestions: (state.districts).isEmpty
                        ? []
                        : state.districts
                              .map((e) => e["name"].toString())
                              .toList(),
                    showSuggestions: _showDistrictSuggestions,
                    onSuggestionSelected: (val) {
                      final selected = state.districts.firstWhere(
                        (e) => e["name"] == val,
                      );

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

                  _buildSearchableTextField(
                    "Pincode*",
                    "Select Pincode",
                    widget.scale,
                    controller: _pincodeTextController,
                    focusNode: _pincodeFocusNode,
                    suggestions: (state.pincodesList).isEmpty
                        ? []
                        : state.pincodesList
                              .map((e) => e["code"].toString())
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

    final filteredSuggestions = suggestions;

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
            color: Colors.white.withOpacity(0.5),
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
                  readOnly: true,
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
                      controller.clear();

                      setState(() {
                        _showStateSuggestions = false;
                        _showDistrictSuggestions = false;
                        _showPincodeSuggestions = false;

                        if (focusNode == _stateFocusNode) {
                          _showStateSuggestions = true;
                        } else if (focusNode == _districtFocusNode) {
                          _showDistrictSuggestions = true;
                        } else if (focusNode == _pincodeFocusNode) {
                          _showPincodeSuggestions = true;
                        }
                      });

                      FocusScope.of(context).requestFocus(focusNode);
                    }
                  },
                ),
              ),
              if (suggestions.isNotEmpty && enabled)
                Icon(Icons.arrow_drop_down, color: Colors.grey, size: s(24)),
            ],
          ),
        ),
        if (showSuggestions && filteredSuggestions.isNotEmpty && enabled)
          Container(
            margin: EdgeInsets.only(top: s(4)),
            constraints: BoxConstraints(maxHeight: s(200)),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(s(20)),
              border: Border.all(color: Colors.white),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: s(10),
                  offset: Offset(0, s(4)),
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
                    height: s(50),
                    margin: EdgeInsets.symmetric(
                      horizontal: s(10),
                      vertical: s(6),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: s(20),
                      vertical: s(12),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(s(18)),
                    ),
                    child: Container(
                      child: Text(
                        suggestion,
                        style: GoogleFonts.lato(
                          fontSize: s(16),
                          fontWeight: FontWeight.w400,
                          color: ColorPalette.textfiledin.withValues(
                            alpha: .80,
                          ),
                        ),
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
            color: Colors.white.withOpacity(0.5),
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

          if (label == "New Customer") {
            existingPanels = [];
            newPanels = [];
          }

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
        context.read<NewRegisterBloc>().add(LoadLocationData());
        widget.onCustomerTypeChanged(label);

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
}
