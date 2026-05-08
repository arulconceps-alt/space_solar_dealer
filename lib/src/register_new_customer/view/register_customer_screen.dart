import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/bloc/alert/alert_state.dart';
import 'package:space_solar_dealer/src/common/widgets/common_app_bar.dart';
import 'package:space_solar_dealer/src/common/widgets/custom_snackbar.dart';
import 'package:space_solar_dealer/src/customer_list/bloc/customer_list_bloc.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';
import 'package:space_solar_dealer/src/register_new_customer/bloc/new_register_bloc.dart' hide LoadCustomers;
import 'package:space_solar_dealer/src/register_new_customer/view/widgets/OrDivider.dart';
import 'package:space_solar_dealer/src/register_new_customer/view/widgets/added_panel_tile.dart';
import 'package:space_solar_dealer/src/register_new_customer/view/widgets/blue_button.dart';
import 'package:space_solar_dealer/src/register_new_customer/view/widgets/customer_details_card.dart';
import 'package:space_solar_dealer/src/register_new_customer/view/widgets/manual_panel_entry.dart';
import 'package:space_solar_dealer/src/register_new_customer/view/widgets/panel_registration_card.dart';
import 'package:space_solar_dealer/src/register_new_customer/view/widgets/register_success_dialog.dart';

class RegisterCustomerScreen extends StatefulWidget {
  const RegisterCustomerScreen({super.key});

  @override
  State<RegisterCustomerScreen> createState() => _RegisterCustomerScreenState();
}

class _RegisterCustomerScreenState extends State<RegisterCustomerScreen> {
  final GlobalKey<CustomerDetailsCardState> customerKey = GlobalKey();
  bool _dialogShown = false;
  List<String> allPanels = []; // Combined panels (existing + new)
  List<String> newPanelsOnly = []; // Only new panels added
  String _selectedCustomerType = "New Customer";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController areaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<NewRegisterBloc>().add(LoadLocationData());
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    pincodeController.dispose();
    stateController.dispose();
    districtController.dispose();
    areaController.dispose();
    super.dispose();
  }

  void _clearForm() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    addressController.clear();
    pincodeController.clear();
    stateController.clear();
    districtController.clear();
    areaController.clear();
    allPanels.clear();
    newPanelsOnly.clear();
    setState(() {});
  }

  bool _validateFields() {
    final blocState = context.read<NewRegisterBloc>().state;

    if (nameController.text.trim().isEmpty)
      return _showError("Enter customer name");
    if (phoneController.text.trim().length != 10)
      return _showError("Enter valid 10-digit phone number");
    if (!emailController.text.contains("@"))
      return _showError("Enter valid email");
    if (blocState.selectedStateId == null) return _showError("Select state");
    if (blocState.selectedDistrictId == null)
      return _showError("Select district");
    if (blocState.selectedPincodeId == null)
      return _showError("Select pincode");
    if (addressController.text.trim().isEmpty)
      return _showError("Enter address");
    
    if (_selectedCustomerType == "Register Panles" && allPanels.isEmpty) {
      return _showError("Add at least one panel");
    }
    
    return true;
  }

  bool _showError(String message) {
    CustomSnackBar.show(
      context,
      AlertState(
        message: message,
        type: AlertType.failure,
        timestamp: DateTime.now(),
      ),
    );
    return false;
  }

  void _updatePanels(List<String> panels) {
    setState(() {
      allPanels = panels;
    });
  }

  void _updateNewPanels(List<String> newPanels) {
    setState(() {
      newPanelsOnly = newPanels;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 440;
    double s(double v) => v * scale;

    return BlocConsumer<NewRegisterBloc, NewRegisterState>(
      listener: (context, state) {
        if (state.status == NewRegisterStatus.success && !_dialogShown) {
          _dialogShown = true;
          
           context.read<CustomerListBloc>().add(LoadCustomers());
          final newPanels = customerKey.currentState?.getNewPanelsOnly() ?? [];
          
          _showSuccessDialog(context, scale, newPanels, _selectedCustomerType);
          _clearForm();
        }
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
      builder: (context, state) {
        final isLoading = state.status == NewRegisterStatus.loading;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CommonAppBar(
            scale: scale,
            showBack: true,
            showNotification: true,
            onBackTap: () => context.pop(),
          ),
          body: Stack(
            children: [
              AppBackground(
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: s(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: s(24)),
                        Text(
                          'Register Customer & Panel IDs',
                          style: GoogleFonts.poppins(
                            color: ColorPalette.bottomtext,
                            fontSize: s(20),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: s(20)),

                        CustomerDetailsCard(
                          key: customerKey,
                          scale: scale,
                          nameController: nameController,
                          phoneController: phoneController,
                          emailController: emailController,
                          stateController: stateController,
                          districtController: districtController,
                          pincodeController: pincodeController,
                          addressController: addressController,
                          onCustomerTypeChanged: (type) {
                            setState(() => _selectedCustomerType = type);
                          },
                          onClearPanels: () => setState(() {
                            allPanels.clear();
                            newPanelsOnly.clear();
                          }),
                          onPanelsLoaded: (apiPanels) {
                            setState(() => allPanels = apiPanels);
                          },
                        ),

                        SizedBox(height: s(20)),

                        if (_selectedCustomerType == "Register Panels") ...[
                        PanelRegistrationCard(
  scale: scale,
  onScanResult: (serial) {
    final formattedId = serial.startsWith("SS-78A00-S")
        ? serial
        : "SS-78A00-S${serial.padLeft(3, '0')}";

    customerKey.currentState?.addNewPanel(formattedId);

    setState(() {
      allPanels = customerKey.currentState?.allPanels ?? [];
      newPanelsOnly =
          customerKey.currentState?.getNewPanelsOnly() ?? [];
    });
  },
),
                          SizedBox(height: s(30)),
                          OrDivider(scale: scale),
                          SizedBox(height: s(30)),
                          ManualPanelEntry(
                            scale: scale,
                            panels: allPanels,
                            onAdd: (value) {
                              final formattedId = value.startsWith("SS-78A00-S")
                                  ? value
                                  : "SS-78A00-S${value.padLeft(3, '0')}";
                              customerKey.currentState?.addNewPanel(formattedId);
                              _updateNewPanels(customerKey.currentState?.getNewPanelsOnly() ?? []);
                            },
                            onRemove: (value) {
                              customerKey.currentState?.removeNewPanel(value);
                              _updateNewPanels(customerKey.currentState?.getNewPanelsOnly() ?? []);
                            },
                          ),
                          SizedBox(height: s(31)),
                          
                          // Display all panels (existing + new)
                          if (allPanels.isNotEmpty) ...[
                            Text(
                              "Registered Panels",
                              style: GoogleFonts.lato(
                                fontSize: s(14),
                                fontWeight: FontWeight.w600,
                                color: ColorPalette.bottomtext,
                              ),
                            ),
                            SizedBox(height: s(12)),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: allPanels.length,
                              separatorBuilder: (_, __) => SizedBox(height: s(16)),
                              itemBuilder: (context, index) {
                                final panel = allPanels[index];
                                final isExisting = customerKey.currentState?.existingPanels.contains(panel) ?? false;
                                
                                return AddedPanelTile(
                                  id: panel,
                                  scale: scale,
                                  showRemove: !isExisting,
                                  isExisting: isExisting,
                                  onRemove: () {
                                    customerKey.currentState?.removeNewPanel(panel);
                                    _updateNewPanels(customerKey.currentState?.getNewPanelsOnly() ?? []);
                                  },
                                );
                              },
                            ),
                            SizedBox(height: s(31)),
                          ],
                        ],

                        SizedBox(height: s(31)),

                        BlueButton(
                          text: state.status == NewRegisterStatus.loading
                              ? "Submitting..."
                              : "Submit",
                          scale: scale,
                          onTap: () {
                            if (!_validateFields()) return;

                            final blocState = context.read<NewRegisterBloc>().state;
                            
                            // Use only NEW panels for registration
                            final panelsToRegister = _selectedCustomerType == "Register Panels"
                                ? (customerKey.currentState?.getNewPanelsOnly() ?? [])
                                : allPanels;

                            if (_selectedCustomerType == "Register Panels" && panelsToRegister.isEmpty) {
                              _showError("Add at least one NEW panel to register");
                              return;
                            }


                            context.read<NewRegisterBloc>().add(
                              NewRegisterSubmit(
                                name: nameController.text.trim(),
                                phone: phoneController.text.trim(),
                                email: emailController.text.trim(),
                                addressLine: addressController.text.trim(),
                                panels: panelsToRegister,
                                stateId: blocState.selectedStateId ?? 0,
                                districtId: blocState.selectedDistrictId ?? 0,
                                pincodeId: blocState.selectedPincodeId ?? 0,
                                propertyType: "commercial",
                                rooftopArea: 2500,
                                electricityBill: 12000,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: s(50)),
                      ],
                    ),
                  ),
                ),
              ),
              if (isLoading)
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(
                      color: Colors.black.withOpacity(0.35),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: ColorPalette.background,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, double scale, List<String> newPanels, String customerType,) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Success",
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => const SizedBox(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.scale(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
          ).value,
          child: Opacity(
            opacity: animation.value,
            child: Dialog(
              backgroundColor: Colors.transparent,
              child: RegistrationSuccessScreen(
                customerType: customerType,
                scale: scale,
                newPanels: newPanels, 
              ),
            ),
          ),
        );
      },
    ).then((_) {
      _dialogShown = false;
       context.read<NewRegisterBloc>().add(ResetRegisterState());
    });
  }
}