import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/repo/ticket_list_details_repositary.dart';
import '../../../common/models/panel_model.dart';

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

  @override
  void initState() {
    super.initState();
    fetchPanels();
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
      print("❌ PANEL ERROR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * widget.scale;

    return Container(
      height: s(50),
      padding: EdgeInsets.symmetric(horizontal: s(12)),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6), // Match design background
        borderRadius: BorderRadius.circular(s(10)),
      ),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : DropdownButtonHideUnderline(
        child: DropdownButton<PanelModel>(
          value: panels.contains(selectedPanel) ? selectedPanel : null,
          hint: Text(
            panels.isEmpty ? "No Panels Found" : "Select Panel ID",
             style: GoogleFonts.lato(
                    color: const Color(0xCC484848),
                    fontSize: s(16),
                    fontWeight: FontWeight.w400,
                  ),
          ),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),

          items: panels.map((panel) {
            return DropdownMenuItem<PanelModel>(
              value: panel,
              child: Text(
                panel.serialNumber.toString(),
                style: TextStyle(fontSize: s(14)),
              ),
            );
          }).toList(),

          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedPanel = value;
              });

              widget.onSelected(value);
            }
          },
        ),
      ),
    );
  }
}