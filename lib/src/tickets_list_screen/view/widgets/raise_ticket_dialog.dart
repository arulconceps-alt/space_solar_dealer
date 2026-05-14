import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/bloc/alert/alert_state.dart';
import 'package:space_solar_dealer/src/common/models/issue_model.dart';
import 'package:space_solar_dealer/src/common/models/panel_model.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';
import 'package:space_solar_dealer/src/common/widgets/custom_snackbar.dart';
import 'package:space_solar_dealer/src/register_new_customer/repo/new_register_repositary.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/bloc/ticket_list_details_bloc.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/bloc/ticket_list_details_state.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/repo/ticket_list_details_repositary.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/widgets/description_field.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/widgets/issue_dropdown_field.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/widgets/ticket_success_dialog.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/widgets/upload_field.dart';
import '../../bloc/ticket_list_details_event.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class RaiseTicketDialog extends StatefulWidget {
  final BuildContext parentContext;
  final ScrollController? scrollController;

  const RaiseTicketDialog({
    super.key,
    required this.parentContext,
    this.scrollController,
  });

  @override
  State<RaiseTicketDialog> createState() => _RaiseTicketDialogState();
}

class _RaiseTicketDialogState extends State<RaiseTicketDialog> {
  // Repository
  late NewRegisterRepositary _newRegisterRepository;

  // Controllers
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _panelIdController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // State
  List<Map<String, dynamic>> _searchResults = [];
  bool _showSuggestions = false;
  bool _isSearching = false;
  List<Map<String, dynamic>> _allCustomers = [];

  Map<String, dynamic>? _selectedCustomer;
  List<String> _selectedPanelIds = [];
  List<PanelModel> _availablePanels = [];

  IssueModel? selectedIssue;
  String? selectedPriority;
  DateTime selectedDate = DateTime.now();
  final ImagePicker _picker = ImagePicker();
  List<File> selectedImages = [];
  final List<String> _priorityOptions = ["High", "Medium", "Low"];
  String? _tempSelectedPanel;

  @override
  void initState() {
    super.initState();
    final apiRepository = context.read<ApiRepository>();
    _newRegisterRepository = NewRegisterRepositary(apiRepository);
    _fetchAllCustomers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _phoneController.dispose();
    _customerNameController.dispose();
    _panelIdController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage();

    if (images.isNotEmpty) {
      setState(() {
        selectedImages.addAll(images.map((e) => File(e.path)).toList());
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  Future<void> _fetchAllCustomers() async {
    try {
      final customers = await _newRegisterRepository.getCustomers();
      setState(() {
        _allCustomers = customers;
      });
    } catch (e) {
      print("Error fetching customers: $e");
    }
  }

  void _onSearch(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _showSuggestions = false;
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _showSuggestions = true;
    });

    // Simulate slight delay for better UX
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;

      final filtered = _allCustomers.where((customer) {
        final name = customer["name"]?.toString().toLowerCase() ?? "";
        final phone =
            customer["phone"]?.toString().replaceAll("+91", "").toLowerCase() ??
            "";
        final queryLower = query.trim().toLowerCase();

        return name.contains(queryLower) || phone.contains(queryLower);
      }).toList();

      setState(() {
        _searchResults = filtered;
        _isSearching = false;
      });
    });
  }

  void _onCustomerSelected(Map<String, dynamic> customer) {
    final List<PanelModel> panels = [];

    final soldSerials = (customer["soldSerials"] as List?) ?? [];

    for (final item in soldSerials) {
      if (item is! Map<String, dynamic>) continue;

      final serial = (item["serialNumber"] ?? "").toString();
      if (serial.trim().isEmpty) continue;

      panels.add(
        PanelModel(
          productId: item["productId"] ?? 0,
          productName: item["productName"] ?? "",
          serialNumber: serial,
          orderNumber: item["orderNumber"] ?? "",
          soldAt: DateTime.tryParse(item["soldAt"] ?? ""),
          customerId: customer["id"]?.toString() ?? "",
          customerName: customer["name"] ?? "",
          customerPhone: customer["phone"] ?? "",
          customerEmail: customer["email"] ?? "",
          customerAddress: customer["addressLine1"] ?? "",
          performanceWarrantyEndDate: DateTime.tryParse(
            item["performanceWarrantyEndDate"] ?? "",
          ),
          physicalWarrantyEndDate: DateTime.tryParse(
            item["physicalWarrantyEndDate"] ?? "",
          ),
          warrantyStartDate: DateTime.tryParse(item["warrantyStartDate"] ?? ""),
        ),
      );
    }

    String phone = (customer["phone"] ?? "").toString();
    if (phone.startsWith("+91")) {
      phone = phone.substring(3);
    }

    setState(() {
      _selectedCustomer = customer;
      _availablePanels = panels;

      _phoneController.text = phone;
      _customerNameController.text = customer["name"] ?? "";

      _searchController.clear();
      _showSuggestions = false;
      _searchResults = [];
      _selectedPanelIds.clear();
      _panelIdController.clear();
    });
  }

  void _removePanelId(String id) {
    setState(() => _selectedPanelIds.remove(id));
  }

  void _resetForm() {
    _searchController.clear();
    _phoneController.clear();
    _customerNameController.clear();
    _panelIdController.clear();
    descriptionController.clear();
    setState(() {
      _selectedCustomer = null;
      _availablePanels = [];
      _selectedPanelIds = [];
      _searchResults = [];
      _showSuggestions = false;
      selectedIssue = null;
      selectedPriority = null;
    });
  }

  void _showErr(String msg) {
    CustomSnackBar.show(
      context,
      AlertState(
        message: msg,
        type: AlertType.failure,
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;
    double s(double v) => v * scale;

    return BlocListener<TicketListDetailsBloc, TicketListDetailsState>(
      listener: (context, state) {
        if (state.status == TicketListDetailsStatus.create) {
          Navigator.pop(context);
          final newTicket = state.tickets.first;
          _resetForm();

          context.read<TicketListDetailsBloc>().add(LoadTicketsEvent());

          showGeneralDialog(
            context: widget.parentContext,
            barrierDismissible: true,
            barrierLabel: "Success",
            barrierColor: Colors.black54,
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (_, __, ___) => TicketSuccessDialog(
              parentContext: widget.parentContext,
              ticket: newTicket,
            ),
          );
        }
        if (state.status == TicketListDetailsStatus.failure) {
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
      child: SingleChildScrollView(
        controller: widget.scrollController,
        child: Padding(
          padding: EdgeInsets.all(s(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Raise New Ticket",
                    style: GoogleFonts.poppins(
                      color: ColorPalette.bottomtext,
                      fontSize: s(18),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      "assets/images/ticket/cross_icon.png",
                      width: s(12.73),
                      height: s(12.73),
                    ),
                  ),
                ],
              ),

              SizedBox(height: s(20)),

              _buildSearchField(s),

              SizedBox(height: s(16)),

              _buildLabel("Phone Number*", s),
              SizedBox(height: s(10)),
              _buildReadOnlyField(
                controller: _phoneController,
                hint: "Phone Number",
                s: s,
              ),

              SizedBox(height: s(16)),

              _buildLabel("Customer Name*", s),
              SizedBox(height: s(10)),
              _buildReadOnlyField(
                controller: _customerNameController,
                hint: "Customer Name",
                s: s,
              ),

              SizedBox(height: s(16)),

              _buildLabel("Panel ID*", s),
              SizedBox(height: s(10)),
              _buildPanelIdRow(s),

              // Panel ID chips
              if (_selectedPanelIds.isNotEmpty) ...[
                SizedBox(height: s(12)),
                _buildPanelChips(s),
              ],

              SizedBox(height: s(16)),

              _buildLabel("Select Issue type*", s),
              SizedBox(height: s(10)),
              IssueDropdownField(
                scale: scale,
                onSelected: (value) {
                  setState(() => selectedIssue = IssueModel(value));
                },
              ),

              SizedBox(height: s(16)),

              _buildLabel("Priority*", s),
              SizedBox(height: s(10)),
              _buildPriorityDropdown(s),

              SizedBox(height: s(16)),
              DescriptionField(scale: scale, controller: descriptionController),

              SizedBox(height: s(16)),

              UploadField(
                scale: scale,
                onTap: _pickImages,
                files: selectedImages,
                onRemove: _removeImage,
              ),

              SizedBox(height: s(40)),

              _buildSubmitButton(s, context),

              SizedBox(height: s(20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(double Function(double) s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SEARCH FIELD
        Container(
          height: s(52),
          decoration: BoxDecoration(
            color: Color(0xFFF6F6F6),
            borderRadius: BorderRadius.circular(s(10)),
            border: Border.all(color: Color(0xFF000000).withOpacity(0.20)),
          ),
          padding: EdgeInsets.symmetric(horizontal: s(16)),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: ColorPalette.textfiledin.withOpacity(0.80),
                size: s(18),
              ),

              SizedBox(width: s(10)),

              Expanded(
                child: TextField(
                  controller: _searchController,
                  style: GoogleFonts.lato(
                    fontSize: s(16),
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6D6D6D),
                  ),

                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,

                    hintText: "Search by Phone Number or Customer",

                    hintStyle: GoogleFonts.lato(
                      fontSize: s(16),
                      fontWeight: FontWeight.w400,
                      color: ColorPalette.textfiledin.withOpacity(0.80),
                    ),
                  ),

                  onChanged: _onSearch,
                ),
              ),

              if (_isSearching)
                SizedBox(
                  width: s(18),
                  height: s(18),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: const Color(0xFF26A7DF),
                  ),
                ),
            ],
          ),
        ),

        // DROPDOWN SUGGESTIONS
        if (_showSuggestions && _searchResults.isNotEmpty) ...[
          SizedBox(height: s(10)),

          Container(
            constraints: BoxConstraints(maxHeight: s(280)),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.96),
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
              padding: EdgeInsets.symmetric(vertical: s(8)),
              shrinkWrap: true,
              itemCount: _searchResults.length,

              itemBuilder: (context, index) {
                final c = _searchResults[index];

                final name = c["name"] ?? "";

                String phone = (c["phone"] ?? "").toString();

                if (phone.startsWith("+91")) {
                  phone = phone.substring(3);
                }

                return GestureDetector(
                  onTap: () => _onCustomerSelected(c),

                  child: Container(
                    height: s(50),

                    margin: EdgeInsets.symmetric(
                      horizontal: s(10),
                      vertical: s(6),
                    ),

                    padding: EdgeInsets.symmetric(horizontal: s(16)),

                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(s(18)),
                    ),

                    alignment: Alignment.centerLeft,

                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "$name - $phone",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,

                            style: GoogleFonts.lato(
                              fontSize: s(16),
                              fontWeight: FontWeight.w400,
                              color: ColorPalette.textfiledin.withValues(
                                alpha: .80,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],

        // NO RESULT UI
        if (_showSuggestions &&
            !_isSearching &&
            _searchResults.isEmpty &&
            _searchController.text.trim().isNotEmpty) ...[
          SizedBox(height: s(10)),

          Container(
            height: s(60),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.96),
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

            alignment: Alignment.center,

            child: Text(
              "No customers found",

              style: GoogleFonts.lato(
                fontSize: s(16),
                fontWeight: FontWeight.w400,
                color: ColorPalette.textfiledin.withValues(alpha: .80),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPanelIdRow(double Function(double) s) {
    final panelOptions = _availablePanels
        .map((p) => p.serialNumber)
        .where((v) => v.isNotEmpty)
        .where((v) => !_selectedPanelIds.contains(v))
        .toList();

    // SELECT CUSTOMER FIRST
    if (_selectedCustomer == null) {
      return Container(
        height: s(52),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(s(10)),
        ),
        padding: EdgeInsets.symmetric(horizontal: s(18)),
        alignment: Alignment.centerLeft,
        child: Text(
          "Select a customer first",
          style: GoogleFonts.lato(
            fontSize: s(16),
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6D6D6D),
          ),
        ),
      );
    }

    // NO PANELS
    if (_availablePanels.isEmpty) {
      return Container(
        height: s(52),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(s(10)),
        ),
        padding: EdgeInsets.symmetric(horizontal: s(18)),
        alignment: Alignment.centerLeft,
        child: Text(
          "No panels available",
          style: GoogleFonts.lato(
            fontSize: s(16),
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6D6D6D),
          ),
        ),
      );
    }

    // ALL PANELS ADDED
    if (panelOptions.isEmpty) {
      return Container(
        height: s(52),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(s(10)),
        ),
        padding: EdgeInsets.symmetric(horizontal: s(18)),
        alignment: Alignment.centerLeft,
        child: Text(
          "All panels added",
          style: GoogleFonts.lato(
            fontSize: s(16),
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6D6D6D),
          ),
        ),
      );
    }

    // DROPDOWN UI
      return Container(
        height: s(52),

        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(s(10)),
        ),

        padding: EdgeInsets.symmetric(horizontal: s(16)),

        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: null,
            isExpanded: true,

            menuMaxHeight: s(280),

            dropdownColor: Colors.white,

            borderRadius: BorderRadius.circular(s(20)),

            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: const Color(0xFF6D6D6D),
              size: s(22),
            ),

            hint: Text(
              "Select Panel ID",
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.lato(
                fontSize: s(16),
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6D6D6D),
              ),
            ),

            style: GoogleFonts.lato(
              fontSize: s(16),
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6D6D6D),
            ),

            items: panelOptions.map((item) {
              return DropdownMenuItem<String>(
                value: item,

                child: Text(
                  item,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(
                    fontSize: s(16),
                    fontWeight: FontWeight.w400,
                    color: ColorPalette.textfiledin.withValues(alpha: .80),
                  ),
                ),
              );
            }).toList(),

            onChanged: (val) {
              if (val == null) return;

              if (_selectedPanelIds.contains(val)) {
                CustomSnackBar.show(
                  context,
                  AlertState(
                    message: "Panel ID '$val' already added",
                    type: AlertType.failure,
                    timestamp: DateTime.now(),
                  ),
                );
                return;
              }

              setState(() {
                _selectedPanelIds.add(val);
              });
            },
          ),
        ),
      );
    }

  Widget _buildPanelChips(double Function(double) s) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.all(s(16)),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(s(10)),
        border: Border.all(
          color: Color(0xFF000000).withOpacity(0.30),
          width: s(1),
        ),
      ),

      child: Wrap(
        spacing: s(8),
        runSpacing: s(8),

        children: _selectedPanelIds.map((id) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: s(12), vertical: s(7)),

            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(s(8)),
            ),

            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  id,
                  style: GoogleFonts.lato(
                    fontSize: s(13),
                    color: ColorPalette.bottomtext,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                //SizedBox(width: s(6)),

                // GestureDetector(
                //   onTap: () => _removePanelId(id),
                //   child: Icon(
                //     Icons.close,
                //     size: s(14),
                //     color: Colors.grey.shade500,
                //   ),
                // ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }


 Widget _buildPriorityDropdown(double Function(double) s) {
  return Container(
    height: s(52),

    decoration: BoxDecoration(
      color:  Colors.grey.withOpacity(0.05),
      borderRadius: BorderRadius.circular(s(10)),
    ),

    padding: EdgeInsets.symmetric(horizontal: s(16)),

    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedPriority,

        isExpanded: true,

        menuMaxHeight: s(300),

        dropdownColor: Colors.white,

        borderRadius: BorderRadius.circular(s(20)),

        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: const Color(0xFF6D6D6D),
          size: s(22),
        ),

        hint: Text(
          "Select Priority",
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.lato(
            fontSize: s(16),
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6D6D6D),
          ),
        ),

        style: GoogleFonts.lato(
          fontSize: s(16),
          fontWeight: FontWeight.w400,
          color: const Color(0xFF6D6D6D),
        ),

        items: _priorityOptions.map((item) {
          return DropdownMenuItem<String>(
            value: item,

            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: s(6),
                vertical: s(4),
              ),

              child: Text(
                item,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,

                style: GoogleFonts.lato(
                  fontSize: s(16),
                  fontWeight: FontWeight.w400,
                  color:
                      ColorPalette.textfiledin.withValues(alpha: .80),
                ),
              ),
            ),
          );
        }).toList(),

        onChanged: (val) {
          setState(() {
            selectedPriority = val;
          });
        },
      ),
    ),
  );
}

  Widget _buildReadOnlyField({
    required TextEditingController controller,
    required String hint,
    required double Function(double) s,
  }) {
    return Container(
      height: s(52),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(s(10)),
      ),
      padding: EdgeInsets.symmetric(horizontal: s(14)),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: controller,
        readOnly: true,
        style: GoogleFonts.lato(
          fontSize: s(15),
          color: ColorPalette.bottomtext,
        ),
        decoration: InputDecoration(
          isCollapsed: true,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: GoogleFonts.lato(
            fontSize: s(16),
            fontWeight: FontWeight.w400,
            color: const Color(0xFF484848).withOpacity(0.80),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, double Function(double) s) {
    return Text(
      text,
      style: GoogleFonts.lato(
        fontSize: s(15),
        fontWeight: FontWeight.w600,
        color: ColorPalette.bottomtext,
      ),
    );
  }

  Widget _buildSubmitButton(double Function(double) s, BuildContext context) {
    return BlocBuilder<TicketListDetailsBloc, TicketListDetailsState>(
      builder: (context, state) {
        final isLoading = state.status == TicketListDetailsStatus.loading;

        return GestureDetector(
          onTap: isLoading
              ? null
              : () {
                  if (_selectedCustomer == null) {
                    _showErr("Please search and select a customer");
                    return;
                  }
                  if (_selectedPanelIds.isEmpty) {
                    _showErr("Please add at least one Panel ID");
                    return;
                  }
                  if (selectedIssue == null) {
                    _showErr("Please select an issue type");
                    return;
                  }
                  if (selectedPriority == null) {
                    _showErr("Please select priority");
                    return;
                  }
                  if (descriptionController.text.trim().isEmpty) {
                    _showErr("Please enter description");
                    return;
                  }

                  final products = _selectedPanelIds.map((serial) {
                    final match = _availablePanels.firstWhere(
                      (p) => p.serialNumber == serial,
                      orElse: () => PanelModel(
                        productId: 0,
                        productName: '',
                        serialNumber: serial,
                        orderNumber: '',
                        soldAt: null,
                        customerId: '',
                        customerName: '',
                        customerPhone: '',
                        customerAddress: '',
                        customerEmail: '',
                        performanceWarrantyEndDate: null,
                        physicalWarrantyEndDate: null,
                        warrantyStartDate: null,
                      ),
                    );

                    return {
                      "productId": match.productId,
                      "serialNo": serial,
                      "quantity": 1,
                    };
                  }).toList();

                  final ticketData = {
                    "customerId": _selectedCustomer!["id"].toString(),
                    "title": selectedIssue?.title ?? "",
                    "description": descriptionController.text.trim(),
                    "priority": (selectedPriority ?? "MEDIUM").toUpperCase(),
                    "scheduledAt": selectedDate.toUtc().toIso8601String(),
                    "products": products,
                    "category": "MAINTENANCE",
                  };

                  context.read<TicketListDetailsBloc>().add(
                    CreateTicketEvent(ticketData, images: selectedImages),
                  );
                },
          child: Container(
            width: double.infinity,
            height: s(50),
            decoration: BoxDecoration(
              color: isLoading ? Colors.grey : const Color(0xFF26A7DF),
              borderRadius: BorderRadius.circular(s(10)),
            ),
            alignment: Alignment.center,
            child: isLoading
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    'Done',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: s(16),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildCommonDropdown({
    required double Function(double) s,
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      height: s(52),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(s(10)),
      ),
      padding: EdgeInsets.symmetric(horizontal: s(14)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(s(12)),

          hint: Text(
            hint,
            style: GoogleFonts.lato(
              fontSize: s(15),
              fontWeight: FontWeight.w400,
              color: const Color(0xFF484848).withOpacity(0.80),
            ),
          ),

          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.grey,
            size: s(24),
          ),

          style: GoogleFonts.lato(
            fontSize: s(15),
            color: ColorPalette.bottomtext,
            fontWeight: FontWeight.w500,
          ),

          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
