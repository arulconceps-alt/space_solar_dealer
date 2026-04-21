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
  bool _showLoader = false;
  bool _dialogShown = false;
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

    // 🔥 Reset dropdown state
    context.read<NewRegisterBloc>().add(SelectState(""));
    context.read<NewRegisterBloc>().add(SelectDistrict(""));

    setState(() {});
  }
  bool _validateFields() {
    if (nameController.text.trim().isEmpty) {
      _showError("Enter customer name");
      return false;
    }

    if (phoneController.text.trim().isEmpty) {
      _showError("Enter phone number");
      return false;
    }

    if (phoneController.text.trim().length != 10) {
      _showError("Enter valid 10-digit phone number");
      return false;
    }

    if (emailController.text.trim().isEmpty) {
      _showError("Enter email");
      return false;
    }

    if (!emailController.text.contains("@")) {
      _showError("Enter valid email");
      return false;
    }

    if (context.read<NewRegisterBloc>().state.selectedState == null ||
        context.read<NewRegisterBloc>().state.selectedState!.isEmpty) {
      _showError("Select state");
      return false;
    }

    if (context.read<NewRegisterBloc>().state.selectedDistrict == null ||
        context.read<NewRegisterBloc>().state.selectedDistrict!.isEmpty) {
      _showError("Select district");
      return false;
    }

    if (pincodeController.text.trim().isEmpty) {
      _showError("Enter pincode");
      return false;
    }

    if (addressController.text.trim().isEmpty) {
      _showError("Enter address");
      return false;
    }

    if (panels.isEmpty) {
      _showError("Add at least one panel");
      return false;
    }

    return true;
  }
  void _showError(String message) {
    CustomSnackBar.show(
      context,
      AlertState(
        message: message,
        type: AlertType.failure,
        timestamp: DateTime.now(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = screenWidth / 440;
    double s(double v) => v * scale;

    return BlocConsumer<NewRegisterBloc, NewRegisterState>(
      listener: (context, state) async {
        if (state.status == NewRegisterStatus.loading) {
          setState(() {
            _showLoader = true;
          });
        }

        if (state.status == NewRegisterStatus.success && !_dialogShown) {
          await Future.delayed(const Duration(seconds: 1)); // ✅ delay

          setState(() {
            _showLoader = false;
          });

          _dialogShown = true;

          context.read<NewRegisterBloc>().add(const ResetRegisterState());

          _clearForm();
          customerKey.currentState?.resetToNewCustomer();

          _showSuccessDialog(context, scale);
        }

        if (state.status == NewRegisterStatus.failure) {
          await Future.delayed(const Duration(seconds: 1)); // ✅ delay

          setState(() {
            _showLoader = false;
          });

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
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
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
                          onClearPanels: () {
                            setState(() {
                              panels.clear();
                            });
                          },
                          onPanelsLoaded: (apiPanels) {
                            setState(() {
                              panels = apiPanels; // ✅ UPDATE UI
                            });
                          },
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
                            if (_showLoader) return;

                            if (!_validateFields()) return; // ✅ STOP if invalid

                            context.read<NewRegisterBloc>().add(
                              NewRegisterSubmit(
                                name: nameController.text.trim(),
                                phone: phoneController.text.trim(),
                                email: emailController.text.trim(),
                                address: addressController.text.trim(),
                                city: pincodeController.text.trim(),
                                state: context.read<NewRegisterBloc>().state.selectedState ?? "",
                                district: context.read<NewRegisterBloc>().state.selectedDistrict ?? "",
                                area: pincodeController.text.trim(),
                                panels: panels,
                                parentId: "69e32380bf4cad14a1d4b9b7",
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
                    child: CircularProgressIndicator(color: ColorPalette.background,),
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