import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/models/panel_model.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/repo/ticket_list_details_repositary.dart';

class PanelIdField extends StatefulWidget {
  final double scale;
  final Function(PanelModel) onSelected;
  final TicketListDetailsRepositary repository;
  final String customerId;  

  const PanelIdField({
    super.key,
    required this.scale,
    required this.onSelected,
    required this.repository,
    required this.customerId,
  });

  @override
  State<PanelIdField> createState() => _PanelIdFieldState();
}

class _PanelIdFieldState extends State<PanelIdField> {
  List<PanelModel> panels = [];
  PanelModel? selectedPanel;

  bool isLoading = true;
  bool _showDropdown = false;

 @override
void didUpdateWidget(covariant PanelIdField oldWidget) {
  super.didUpdateWidget(oldWidget);

  if (oldWidget.customerId != widget.customerId) {
    fetchPanels();
  }
}

  Future<void> fetchPanels() async {
    try {
      final data = await widget.repository.getPanelIds(widget.customerId);

      setState(() {
        panels = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      debugPrint("❌ PANEL ERROR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * widget.scale;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// FIELD
        GestureDetector(
          onTap: () {
            if (!isLoading && panels.isNotEmpty) {
              setState(() {
                _showDropdown = !_showDropdown;
              });
            }
          },
          child: Container(
            height: s(52),
            padding: EdgeInsets.symmetric(horizontal: s(16)),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(s(10)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: isLoading
                      ? Text(
                          "Select a customer first",
                          style: GoogleFonts.lato(
                            fontSize: s(16),
                            fontWeight: FontWeight.w400,
                            color: ColorPalette.textfiledin.withOpacity(0.8),
                          ),
                        )
                      : Text(
                          selectedPanel?.serialNumber ?? "Select Panel ID",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lato(
                            fontSize: s(16),
                            fontWeight: FontWeight.w400,
                            color:  ColorPalette.textfiledin.withOpacity(0.80)
                          ),
                        ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: const Color(0xFF6D6D6D),
                  size: s(20),
                )
              ],
            ),
          ),
        ),

        /// DROPDOWN (MATCH ISSUE UI EXACTLY)
        if (_showDropdown) ...[
          SizedBox(height: s(8)),

          Container(
            constraints: BoxConstraints(maxHeight: s(200)),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.96),
              borderRadius: BorderRadius.circular(s(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: s(10),
                  offset: Offset(0, s(4)),
                )
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: panels.length,
              itemBuilder: (context, index) {
                final panel = panels[index];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPanel = panel;
                      _showDropdown = false;
                    });

                    widget.onSelected(panel);
                  },
                  child: Container(
                    height: s(50),
                    margin: EdgeInsets.symmetric(
                      horizontal: s(10),
                      vertical: s(6),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: s(16),
                      vertical: s(12),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F1F1),
                      borderRadius: BorderRadius.circular(s(14)),
                    ),
                    child: Text(
                      panel.serialNumber.toString(),
                      style: GoogleFonts.lato(
                        fontSize: s(16),
                        fontWeight: FontWeight.w400,
                        color: ColorPalette.textfiledin.withOpacity(0.80),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ],
    );
  }
}