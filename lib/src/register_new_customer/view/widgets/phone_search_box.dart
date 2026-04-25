
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class PhoneSearchBox extends StatefulWidget {
  final double scale;
  final TextEditingController controller;
  final Function(String) onSearch;
  final List<Map<String, dynamic>> suggestions;
  final Function(Map<String, dynamic>) onSelected;

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

  void _showOverlay() {
    _hideOverlay();
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void didUpdateWidget(covariant PhoneSearchBox oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 🔥 AUTO REFRESH overlay when API results change
    if (widget.suggestions != oldWidget.suggestions) {
      if (widget.suggestions.isNotEmpty &&
          widget.controller.text.isNotEmpty) {
        _showOverlay();
      } else {
        _hideOverlay();
      }
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    double s(double v) => v * widget.scale;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _hideOverlay, // 🔥 tap outside closes
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, size.height + s(8)),
                child: Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(s(12)),
                  child: Container(
                    constraints: BoxConstraints(maxHeight: s(200)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(s(12)),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.suggestions.length,
                      itemBuilder: (context, index) {
                        final user = widget.suggestions[index];

                        return ListTile(
                          dense: true,
                          title: Text(
                            "${user['name'] ?? ''} - ${user['phone'] ?? ''}",
                            style: GoogleFonts.lato(
                              fontSize: s(14),
                              color: const Color(0xFF484848),
                            ),
                          ),
                          onTap: () {
                            widget.onSelected(user); // ✅ full map passed
                            _hideOverlay();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _hideOverlay();
    super.dispose();
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
          border: Border.all(width: s(1), color: Colors.white),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: s(16)),
              child: Image.asset(
                'assets/images/customer/search_icon.png',
                width: s(24),
                height: s(24),
                color: const Color(0xFF484848),
              ),
            ),
            SizedBox(width: s(8.4)),

            Expanded(
              child: TextField(
                controller: widget.controller,
                onChanged: widget.onSearch,
                style: TextStyle(
                  fontSize: s(16),
                  color: ColorPalette.bottomtext,
                ),
                decoration: InputDecoration(
                  isCollapsed: true,
                  hintText: "Search by Phone Number",
                  hintStyle: GoogleFonts.lato(
                    fontSize: s(16),
                    color: ColorPalette.textfiled,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}