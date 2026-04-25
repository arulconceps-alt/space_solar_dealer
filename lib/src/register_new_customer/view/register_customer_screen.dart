import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/bloc/alert/alert_state.dart';
import 'package:space_solar_dealer/src/common/widgets/common_app_bar.dart';
import 'package:space_solar_dealer/src/common/widgets/custom_snackbar.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';
import 'package:space_solar_dealer/src/register_new_customer/bloc/new_register_bloc.dart';
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

  // Removed 'final' from these as they are updated via BLoC state,
  // or simply rely on the BLoC state directly during submit.
  List<String> panels = [];

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
    panels.clear();
    setState(() {});
  }

  bool _validateFields() {
    final blocState = context.read<NewRegisterBloc>().state;

    if (nameController.text.trim().isEmpty) return _showError("Enter customer name");
    if (phoneController.text.trim().length != 10) return _showError("Enter valid 10-digit phone number");
    if (!emailController.text.contains("@")) return _showError("Enter valid email");
    if (blocState.selectedStateId == null) return _showError("Select state");
    if (blocState.selectedDistrictId == null) return _showError("Select district");
    if (blocState.selectedPincodeId == null) return _showError("Select pincode");
    if (addressController.text.trim().isEmpty) return _showError("Enter address");
    if (panels.isEmpty) return _showError("Add at least one panel");

    return true;
  }

  bool _showError(String message) {
    CustomSnackBar.show(context, AlertState(message: message, type: AlertType.failure, timestamp: DateTime.now()));
    return false;
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
          _showSuccessDialog(context, scale);
          _clearForm();
          context.read<NewRegisterBloc>().add(ResetRegisterState());
        }
        if (state.status == NewRegisterStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error: ${state.message}"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
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
                          onClearPanels: () => setState(() => panels.clear()),
                          onPanelsLoaded: (apiPanels) => setState(() => panels = apiPanels),
                        ),

                        SizedBox(height: s(20)),
                        PanelRegistrationCard(scale: scale),
                        SizedBox(height: s(30)),
                        OrDivider(scale: scale),
                        SizedBox(height: s(30)),

                        ManualPanelEntry(
                          scale: scale,
                          panels: panels,
                          onAdd: (value) {
                            setState(() {
                              if (!panels.contains(value)) {
                                panels.add(value);
                              }
                            });
                          },
                          onRemove: (value) {
                            setState(() {
                              panels.remove(value);
                            });
                          },
                        ),
                        SizedBox(height: s(31)),

                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: panels.length,
                          itemBuilder: (context, index) {
                            final panel = panels[index];
                            return AddedPanelTile(
                              id: "SS-78A00-S${panel.toString().padLeft(3, '0')}",
                              scale: scale,
                              onRemove: () {
                                setState(() {
                                  panels.remove(panel);
                                });
                              },
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(height: s(16)),
                        ),
                        SizedBox(height: s(31)),

                        BlueButton(
                          text: state.status == NewRegisterStatus.loading
                              ? "Submitting..."
                              : "Submit",
                          scale: scale,
                            onTap: () {
                              if (!_validateFields()) return;

                              final blocState = context.read<NewRegisterBloc>().state;

                              context.read<NewRegisterBloc>().add(
                                NewRegisterSubmit(
                                  name: nameController.text.trim(),
                                  phone: phoneController.text.trim(),
                                  addressLine: addressController.text.trim(),
                                  stateId: blocState.selectedStateId!,
                                  districtId: blocState.selectedDistrictId!,
                                  pincodeId: blocState.selectedPincodeId!,
                                  panels: panels,
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

              /// ✅ LOADING OVERLAY
              if (state.status == NewRegisterStatus.loading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: ColorPalette.background,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, double scale) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Success",
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => const SizedBox(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.scale(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack).value,
          child: Opacity(
            opacity: animation.value,
            child: Dialog(
              backgroundColor: Colors.transparent,
              child: RegistrationSuccessScreen(scale: scale),
            ),
          ),
        );
      },
    );
  }
}