import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/bloc/alert/alert_state.dart';
import 'package:space_solar_dealer/src/common/models/customer_model.dart';
import 'package:space_solar_dealer/src/common/repos/api_repository.dart';
import 'package:space_solar_dealer/src/common/widgets/common_app_bar.dart';
import 'package:space_solar_dealer/src/common/widgets/custom_snackbar.dart';
import 'package:space_solar_dealer/src/customer_list/repo/customer_list_repositary.dart';
import 'package:space_solar_dealer/src/dashboard/view/widgets/app_background.dart';

class CustomerEditScreen extends StatefulWidget {
  final CustomerModel customer;

  const CustomerEditScreen({
    super.key,
    required this.customer,
  });

  @override
  State<CustomerEditScreen> createState() => _CustomerEditScreenState();
}

class _CustomerEditScreenState extends State<CustomerEditScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _addressController;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.customer.name);
    _phoneController = TextEditingController(text: widget.customer.phone);
    _emailController =
        TextEditingController(text: widget.customer.email ?? '');
    _addressController =
        TextEditingController(text: widget.customer.addressLine1);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() => _isSaving = true);

  try {
    final repo = CustomerListRepositary(context.read<ApiRepository>());

  final updatedData = {
  "name": _nameController.text.trim(),
  "phone": _phoneController.text.trim(),
  "email": _emailController.text.trim(),
  "address": {
    "line1": _addressController.text.trim(),
    "countryId": widget.customer.countryId,
    "stateId": widget.customer.stateId,
    "districtId": widget.customer.districtId,
    "pincodeId": widget.customer.pincodeId,
  }
};

    final response = await repo.updateCustomer(
      customerId: widget.customer.id,
      updatedData: updatedData,
    );

     CustomSnackBar.show(
      context,
      AlertState(
        type: AlertType.success,
        message: "Customer updated successfully",
         timestamp: DateTime.now(),
      ),
    );

    print("🎉 UPDATE SUCCESS: $response");

    final updatedCustomer = widget.customer.copyWith(
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      addressLine1: _addressController.text.trim(),
    );

    if (mounted) {
      context.pop(updatedCustomer);
    }
  } catch (e) {
    print("❌ UPDATE ERROR: $e");

   CustomSnackBar.show(
      context,
      AlertState(
        type: AlertType.failure,
        message: "Update failed. Please try again.",
         timestamp: DateTime.now(),
      ),
    );
  } finally {
    if (mounted) {
      setState(() => _isSaving = false);
    }
  }
}
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;

    double s(double v) => v * scale;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: CommonAppBar(
        scale: scale,
        showBack: true,
        onBackTap: () => context.pop(),
      ),
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: s(20)),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: s(24)),

                        Text(
                          'Edit Customer',
                          style: GoogleFonts.poppins(
                            color: ColorPalette.bottomtext,
                            fontSize: s(20),
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: s(22)),

                        // Avatar
                        Center(
                          child: Container(
                            width: s(100),
                            height: s(100),
                            decoration: BoxDecoration(
                              color:
                                  ColorPalette.whitetext.withOpacity(0.50),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ColorPalette.whitetext,
                                width: s(1),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              _nameController.text.isNotEmpty
                                  ? _nameController.text[0].toUpperCase()
                                  : 'B',
                              style: GoogleFonts.lato(
                                fontSize: s(48),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: s(30)),

                        // Name Field
                        _buildEditField(
                          label: 'Full Name',
                          controller: _nameController,
                          scale: scale,
                          keyboardType: TextInputType.name,
                          validator: (v) =>
                              (v == null || v.trim().isEmpty)
                                  ? 'Name is required'
                                  : null,
                        ),

                        // Phone Field
                        _buildEditField(
                          label: 'Phone Number',
                          controller: _phoneController,
                          scale: scale,
                          keyboardType: TextInputType.phone,
                          validator: (v) =>
                              (v == null || v.trim().isEmpty)
                                  ? 'Phone number is required'
                                  : null,
                        ),

                        // Email Field
                        _buildEditField(
                          label: 'Email',
                          controller: _emailController,
                          scale: scale,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v != null &&
                                v.isNotEmpty &&
                                !RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(v)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),

                        // Address Field
                        _buildEditField(
                          label: 'Address',
                          controller: _addressController,
                          scale: scale,
                          keyboardType: TextInputType.streetAddress,
                          maxLines: 3,
                          validator: (v) =>
                              (v == null || v.trim().isEmpty)
                                  ? 'Address is required'
                                  : null,
                        ),

                        SizedBox(height: s(40)),

                        // Save Button
                        SizedBox(
                          width: double.infinity,
                          height: s(52),
                          child: ElevatedButton(
                            onPressed: _isSaving ? null : _saveChanges,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorPalette.bottomtext,
                              disabledBackgroundColor:
                                  ColorPalette.bottomtext.withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(s(12)),
                              ),
                              elevation: 0,
                            ),
                            child: _isSaving
                                ? SizedBox(
                                    width: s(22),
                                    height: s(22),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Save Changes',
                                    style: GoogleFonts.poppins(
                                      fontSize: s(16),
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),

                        SizedBox(height: s(40)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditField({
    required String label,
    required TextEditingController controller,
    required double scale,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    double s(double v) => v * scale;

    return Padding(
      padding: EdgeInsets.only(bottom: s(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.lato(
              fontSize: s(16),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: s(10)),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            validator: validator,
            style: GoogleFonts.lato(fontSize: s(14)),
            decoration: InputDecoration(
              filled: true,
              fillColor: ColorPalette.whitetext.withOpacity(0.50),
              contentPadding: EdgeInsets.all(s(14)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(s(10)),
                borderSide:
                    BorderSide(color: ColorPalette.whitetext),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(s(10)),
                borderSide:
                    BorderSide(color: ColorPalette.whitetext),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(s(10)),
                borderSide: BorderSide(
                  color: ColorPalette.bottomtext,
                  width: 1.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(s(10)),
                borderSide:
                    const BorderSide(color: Colors.red, width: 1.2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(s(10)),
                borderSide:
                    const BorderSide(color: Colors.red, width: 1.5),
              ),
              errorStyle: GoogleFonts.lato(fontSize: s(12)),
            ),
          ),
        ],
      ),
    );
  }
}