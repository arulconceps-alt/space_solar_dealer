import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManualPanelEntry extends StatefulWidget {
  final double scale;
  final List<String> panels;
  final Function(String) onAdd;
  final Function(String) onRemove;

  const ManualPanelEntry({
    super.key,
    required this.scale,
    required this.panels,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  State<ManualPanelEntry> createState() => _ManualPanelEntryState();
}

class _ManualPanelEntryState extends State<ManualPanelEntry> {
  final TextEditingController panelController = TextEditingController();
  List<int> panels = [];

  @override
  void dispose() {
    panelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * widget.scale;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(s(20)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(s(20)),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter Panel ID Manual",
            style: GoogleFonts.poppins(
              fontSize: s(18),
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2D2D2D),
            ),
          ),

          SizedBox(height: s(16)),

          Row(
            children: [
              Expanded(
                child: Container(
                  height: s(50),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(s(10)),
                    border: Border.all(color: Colors.white),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: s(16)),
                  child: TextField(
                    controller: panelController, // ✅ FIX
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Enter Panel ID",
                      border: InputBorder.none,
                      hintStyle: GoogleFonts.lato(
                        color: const Color(0xCC484848),
                        fontSize: s(16),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: s(17)),

              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(s(6)),
                  onTap: () {
                    final value = panelController.text.trim();
                    if (widget.panels.contains(value)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Panel already added")),
                      );
                      return;
                    }

                    widget.onAdd(value);
                    panelController.clear();
                  },
                  child: Container(
                    width: s(98),
                    height: s(50),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFF26A7DF),
                      borderRadius: BorderRadius.circular(s(6)),
                    ),
                    child: Text(
                      "Add",
                      style: GoogleFonts.poppins(
                        fontSize: s(16),
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: s(16)),
        ],
      ),
    );
  }
}