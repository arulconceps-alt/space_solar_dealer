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
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry!.markNeedsBuild();
    }
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _updateOverlay() {
    if (widget.controller.text.trim().length >= 3 &&
        widget.suggestions.isNotEmpty) {
      _showOverlay();
    } else {
      _hideOverlay();
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
      builder: (context) {
        final double dynamicHeight = (widget.suggestions.length * s(58)).clamp(
          s(0),
          s(220),
        );

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: _hideOverlay,
          child: Stack(
            children: [
              Positioned(
                width: size.width,
                child: CompositedTransformFollower(
                  link: _layerLink,
                  offset: Offset(0, size.height + s(8)),
                  showWhenUnlinked: false,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      height: dynamicHeight,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(s(12)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: s(10),
                            offset: Offset(0, s(4)),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(s(12)),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: widget.suggestions.length,
                          itemBuilder: (context, index) {
                            final user = widget.suggestions[index];

                            final String name = user["name"]?.toString() ?? "";

                            final String phone =
                                user["phone"]?.toString() ?? "";

                            return InkWell(
                              onTap: () {
                                _hideOverlay();

                                widget.controller.text = phone;

                                widget.controller.selection =
                                    TextSelection.fromPosition(
                                      TextPosition(offset: phone.length),
                                    );

                                widget.onSelected(user);
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(
                                  horizontal: s(14),
                                  vertical: s(14),
                                ),
                                decoration: BoxDecoration(
                                  border: index != widget.suggestions.length - 1
                                      ? Border(
                                          bottom: BorderSide(
                                            color: Colors.grey.shade200,
                                            width: 0.8,
                                          ),
                                        )
                                      : null,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: s(10)),
                                    Expanded(
                                      child: Text(
                                        "$name - $phone",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.lato(
                                          fontSize: s(14),
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF484848),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
                width: s(22),
                height: s(22),
                color: const Color(0xFF484848),
              ),
            ),

            SizedBox(width: s(8)),

            Expanded(
              child: TextField(
                controller: widget.controller,
                cursorColor: const Color(0xFF26A7DF),

                onChanged: (val) {
                  widget.onSearch(val);

                  Future.delayed(const Duration(milliseconds: 120), () {
                    if (mounted) {
                      _updateOverlay();
                    }
                  });
                },

                onTap: () {
                  _updateOverlay();
                },

                style: GoogleFonts.lato(
                  fontSize: s(16),
                  color: ColorPalette.bottomtext,
                ),

                decoration: InputDecoration(
                  isCollapsed: true,
                  border: InputBorder.none,
                  hintText: "Search by Phone Number",
                  hintStyle: GoogleFonts.lato(
                    fontSize: s(16),
                    color: ColorPalette.textfiled,
                  ),
                ),
              ),
            ),

            if (widget.controller.text.isNotEmpty)
              GestureDetector(
                onTap: () {
                  widget.controller.clear();
                  _hideOverlay();

                  setState(() {});
                },
                child: Padding(
                  padding: EdgeInsets.only(right: s(14)),
                  child: Icon(
                    Icons.close,
                    size: s(18),
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
