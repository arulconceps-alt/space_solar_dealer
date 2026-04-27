import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class PhoneSearchBox extends StatefulWidget {
  final double scale;
  final TextEditingController controller;
  final Function(String) onSearch;
  final List<Map<String, dynamic>> suggestions;

  /// ✅ Strong typing (better than dynamic)
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
    if (_overlayEntry != null) return;
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

    if (widget.suggestions != oldWidget.suggestions) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        if (widget.controller.text.length >= 5 &&
            widget.suggestions.isNotEmpty) {
          _showOverlay();
        } else {
          _hideOverlay();
        }
      });
    }
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject();

    if (renderBox is! RenderBox) {
      return OverlayEntry(builder: (_) => const SizedBox());
    }

    final size = renderBox.size;
    double s(double v) => v * widget.scale;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _hideOverlay,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                offset: Offset(0, size.height + s(8)),
                child: Material(
                  elevation: 6,
                  borderRadius: BorderRadius.circular(s(12)),
                  child: Container(
                    constraints: BoxConstraints(maxHeight: s(220)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(s(12)),
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: widget.suggestions.length,
                      itemBuilder: (context, index) {
                        final user = widget.suggestions[index];

                        final name = user["name"] ?? "";
                        final phone = user["phone"] ?? "";

                        return ListTile(
                          dense: true,
                          title: Text(
                            "$name - $phone",
                            style: GoogleFonts.lato(
                              fontSize: s(14),
                              color: const Color(0xFF484848),
                            ),
                          ),

                          /// ✅ FIX: Close first, then send data
                          onTap: () {
                            _hideOverlay();

                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              widget.onSelected(user);
                            });
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
            SizedBox(width: s(8)),

            Expanded(
              child: TextField(
                controller: widget.controller,

                onChanged: (val) {
                  if (val.length < 5) {
                    _hideOverlay();
                    return;
                  }
                  widget.onSearch(val);
                },

                onTap: () {
                  if (widget.controller.text.length >= 5 &&
                      widget.suggestions.isNotEmpty) {
                    _showOverlay();
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

