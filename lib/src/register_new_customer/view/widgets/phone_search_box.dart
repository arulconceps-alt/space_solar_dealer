
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class PhoneSearchBox extends StatefulWidget {
  final double scale;
  final TextEditingController controller;
  final Function(String) onSearch;
  final List<String> suggestions; // Pass API results here
  final Function(String) onSelected;

  const PhoneSearchBox({
    super.key,
    required this.scale,
    required this.controller,
    required this.onSearch,
    required this.suggestions,
    required this.onSelected,
  });

  @override
  State<PhoneSearchBox> createState() => _PhoneSearchBoxState();
}

class _PhoneSearchBoxState extends State<PhoneSearchBox> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isShowing = false;

  void _showOverlay() {
    if (_overlayEntry != null) _overlayEntry!.remove();
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isShowing = true);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) setState(() => _isShowing = false);
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    double s(double v) => v * widget.scale;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + s(8)),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(s(12)),
            color: Colors.white.withOpacity(0.9),
            child: Container(
              padding: EdgeInsets.all(s(4)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(s(12)),
                border: Border.all(color: Colors.white),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: widget.suggestions.map((user) {
                  return ListTile(
                    title: Text(
                      user,
                      style: GoogleFonts.lato(fontSize: s(16), color: const Color(0xFF484848)),
                    ),
                    onTap: () {
                      widget.onSelected(user);
                      _hideOverlay();
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * widget.scale;

    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        height: s(50),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(s(10)),
          border: Border.all(width: s(1),color: Colors.white),
        ),
        child: Row(
          children: [
            Padding(
                padding:  EdgeInsets.only(left: s(16)),
              child: SizedBox(
              width: s(24),
              height: s(24),
              child: Image.asset(
                'assets/images/customer/search_icon.png',
                fit: BoxFit.contain,
                color: const Color(0xFF484848),
              ),
                        ),
            ),
            SizedBox(width: s(8.4),),
            Expanded(
              child: TextField(
                controller: widget.controller,
                onChanged: (val) {
                  widget.onSearch(val);
                  if (val.isNotEmpty && widget.suggestions.isNotEmpty) {
                    _showOverlay();
                  } else {
                    _hideOverlay();
                  }
                },
                style: TextStyle(
                  fontSize: s(16),
                  color: ColorPalette.bottomtext,
                ),
                decoration: InputDecoration(
                  isCollapsed: true,
                  hintText: "Search by Phone Number",
                  hintStyle: GoogleFonts.lato(
                    fontSize: s(16),
                    fontWeight: FontWeight.w400,
                    color: ColorPalette.textfiled,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}