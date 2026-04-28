import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/bloc/alert/alert_state.dart';
import 'package:space_solar_dealer/src/common/models/issue_model.dart';
import 'package:space_solar_dealer/src/common/widgets/custom_snackbar.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/bloc/ticket_list_details_bloc.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/bloc/ticket_list_details_state.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/repo/ticket_list_details_repositary.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/widgets/description_field.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/widgets/dropdown_field.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/widgets/issue_dropdown_field.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/widgets/panelId_field.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/widgets/ticket_success_dialog.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/widgets/upload_field.dart';
import '../../../common/models/panel_model.dart';
import '../../bloc/ticket_list_details_event.dart';

class RaiseTicketDialog extends StatefulWidget {
  final BuildContext parentContext;

  const RaiseTicketDialog({super.key, required this.parentContext});

  @override
  State<RaiseTicketDialog> createState() => _RaiseTicketDialogState();
}
class _RaiseTicketDialogState extends State<RaiseTicketDialog> {
  final TextEditingController panelController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController serialController = TextEditingController();
  PanelModel? selectedPanel;
  IssueModel? selectedIssue;
  String selectedCategory = "MAINTENANCE";
  String selectedPriority = "HIGH";
  final List<IssueModel> issues = [
    IssueModel("Inverter Not Working"),
    IssueModel("Low Power Output"),
    IssueModel("Panel Damage / Crack"),
    IssueModel("Battery Not Charging"),
  ];
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;
    double s(double v) => v * scale;

    return BlocListener<TicketListDetailsBloc, TicketListDetailsState>(
      listener: (context, state) {

        /// ✅ SUCCESS (CREATE)
        if (state.status == TicketListDetailsStatus.create) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context); // close form dialog only
          }

          final newTicket = state.tickets.first;

          /// ✅ CLEAR FIELDS
          descriptionController.clear();
          selectedPanel = null;
          selectedIssue = null;

          /// ✅ SHOW SUCCESS DIALOG
          showGeneralDialog(
            context: widget.parentContext,
            barrierDismissible: true,
            barrierLabel: "Success",
            barrierColor: Colors.black54,
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (_, __, ___) {
              return TicketSuccessDialog(
                parentContext: widget.parentContext,
                ticket: newTicket,
              );
            },
          );
        }

        /// ❌ ERROR
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

        child: Dialog(   // 👈 YOUR EXISTING UI GOES HERE Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: s(20)),
      child: Container(
        width: s(400),
        height: s(706),
        padding: EdgeInsets.all(s(20)),
        decoration: BoxDecoration(
          color: ColorPalette.whitetext,
          borderRadius: BorderRadius.circular(s(20)),
        ),
        child: SingleChildScrollView(
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

              SizedBox(height: s(29)),

              PanelIdField(
                scale: scale,
                repository: context.read<TicketListDetailsRepositary>(),
                onSelected: (panel) {
                  setState(() {
                    selectedPanel = panel;
                    // ✅ This ensures the 'serialNo' in your API request matches the selected panel
                    print("Selected Serial: ${panel.serialNumber}");
                  });
                },
              ),
              SizedBox(height: s(16)),
              IssueDropdownField(
                scale: scale,
                onSelected: (value) {
                  setState(() {
                    selectedIssue = IssueModel(value);
                  });
                },
              ),
              SizedBox(height: s(16)),
              DescriptionField(
                scale: scale,
                controller: descriptionController,
              ),
              SizedBox(height: s(16)),
              UploadField(
                scale: scale,
                onTap: () {
                  print("Upload clicked");
                },
              ),
              SizedBox(height: s(40)),
              GestureDetector(
                onTap: () {
                  if (selectedPanel == null) return;
                  if (selectedIssue == null) return;
                  if (descriptionController.text.trim().isEmpty) return;

                  context.read<TicketListDetailsBloc>().add(
                    CreateTicketEvent({
                      "customerId": selectedPanel?.customerId ?? "",
                      "title": selectedIssue?.title ?? "",
                      "description": descriptionController.text.trim(),
                      "scheduledAt": selectedDate.toUtc().toIso8601String(),
                      "products": [
                        {
                          "productId": selectedPanel?.productId ?? 0,
                          "serialNo": selectedPanel?.serialNumber ?? "",
                          "quantity": 1
                        }
                      ]
                    }),
                  );

                  print("📤 SENDING DATA:");
                  print("customerId: ${selectedPanel?.customerId}");
                  print("productId: ${selectedPanel?.productId}");
                  print("serialNo: ${selectedPanel?.serialNumber}");
                  print("issue: ${selectedIssue?.title}");

                  // ❌ REMOVED Future.delayed BLOCK
                },

                child: Container(
                  width: s(362),
                  height: s(50),
                  decoration: BoxDecoration(
                    color: const Color(0xFF26A7DF),
                    borderRadius: BorderRadius.circular(s(10)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Done',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: s(16),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
        ),
    );
  }
}
