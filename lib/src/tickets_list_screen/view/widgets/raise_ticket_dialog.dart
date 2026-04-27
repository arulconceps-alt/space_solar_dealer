import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/models/issue_model.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/bloc/ticket_list_details_bloc.dart';
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

    return Dialog(
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
                  selectedPanel = panel;
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

             /* GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Future.delayed(const Duration(milliseconds: 200), () {
                    // showDialog(
                    //   context: parentContext,
                    //   barrierDismissible: false,
                    //   builder: (_) => TicketSuccessDialog(
                    //     parentContext: parentContext,
                    //   ),
                    // );
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: "Ticket Details",
                      barrierColor: Colors.black54,
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return TicketSuccessDialog(parentContext: context);
                      },
                      transitionBuilder:
                          (context, animation, secondaryAnimation, child) {
                            final curvedAnimation = CurvedAnimation(
                              parent: animation,
                              curve: Curves.fastOutSlowIn,
                            );

                            return Transform.scale(
                              scale: curvedAnimation.value,
                              child: Opacity(
                                opacity: animation.value,
                                child: child,
                              ),
                            );
                          },
                    );
                  });
                },
                 child:  GestureDetector(
                    onTap: () {
                      // ✅ Validation
                      if (selectedPanel == null) {
                        print("❌ Select Panel");
                        return;
                      }

                      if (selectedIssue == null) {
                        print("❌ Select Issue Type");
                        return;
                      }

                      if (descriptionController.text.trim().isEmpty) {
                        print("❌ Enter Description");
                        return;
                      }

                      // ✅ API CALL (Bloc Event)
                      context.read<TicketListDetailsBloc>().add(
                        CreateTicketEvent({
                          "customerId": selectedPanel!.customerId,
                          "title": selectedIssue!.title, // issue title
                          "description": descriptionController.text.trim(),
                          "category": "MAINTENANCE",
                          "priority": "HIGH",
                          "scheduledAt": selectedDate.toIso8601String(),
                          "products": [
                            {
                              "productId": selectedPanel!.productId,
                              "serialNo": selectedPanel!.serialNumber,
                              "quantity": 1
                            }
                          ]
                        }),
                      );

                      // ✅ Close dialog
                      Navigator.pop(context);

                      // ✅ Optional success UI
                      Future.delayed(const Duration(milliseconds: 200), () {
                        showGeneralDialog(
                          context: widget.parentContext,
                          barrierDismissible: true,
                          barrierColor: Colors.black54,
                          transitionDuration: const Duration(milliseconds: 400),
                          pageBuilder: (_, __, ___) => const SizedBox(),
                          transitionBuilder: (context, animation, _, child) {
                            return Transform.scale(
                              scale: animation.value,
                              child: Opacity(
                                opacity: animation.value,
                                child: TicketSuccessDialog(parentContext: context),
                              ),
                            );
                          },
                        );
                      });
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
                          color: const Color(0xFFFFFFFF),
                          fontSize: s(16),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
              ),*/
              GestureDetector(
                onTap: () {
                  // ✅ Validation
                  if (selectedPanel == null) {
                    print("❌ Select Panel");
                    return;
                  }

                  if (selectedIssue == null) {
                    print("❌ Select Issue Type");
                    return;
                  }

                  if (descriptionController.text.trim().isEmpty) {
                    print("❌ Enter Description");
                    return;
                  }

                  // ✅ CALL API VIA BLOC
                  context.read<TicketListDetailsBloc>().add(
                    CreateTicketEvent({
                      "customerId": selectedPanel!.customerId,
                      "title": selectedIssue!.title,
                      "description": descriptionController.text.trim(),
                      "category": selectedCategory,
                      "priority": selectedPriority,
                      "scheduledAt": selectedDate.toIso8601String(),
                      "products": [
                        {
                          "productId": selectedPanel!.productId,
                          "serialNo": selectedPanel!.serialNumber,
                          "quantity": 1
                        }
                      ]
                    }),
                  );

                  // ❌ CLOSE CURRENT DIALOG
                  Navigator.pop(context);

                  // ✅ SHOW SUCCESS AFTER SMALL DELAY
                  Future.delayed(const Duration(milliseconds: 300), () {
                    showGeneralDialog(
                      context: widget.parentContext,
                      barrierDismissible: true,
                      barrierColor: Colors.black54,
                      transitionDuration: const Duration(milliseconds: 400),
                      pageBuilder: (_, __, ___) {
                        return  TicketSuccessDialog(parentContext: context);
                      },
                      transitionBuilder: (context, animation, _, child) {
                        return Transform.scale(
                          scale: animation.value,
                          child: Opacity(
                            opacity: animation.value,
                            child: child,
                          ),
                        );
                      },
                    );
                  });
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
    );
  }
}
