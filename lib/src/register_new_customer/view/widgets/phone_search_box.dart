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
    if (widget.controller.text.trim().isNotEmpty &&
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

    final searchText = widget.controller.text.toLowerCase();

    final filteredSuggestions = widget.suggestions.where((user) {
      final name = (user["name"] ?? "").toString().toLowerCase();

      final phone = (user["phone"] ?? "").toString().toLowerCase();

      return name.contains(searchText) || phone.contains(searchText);
    }).toList();

    return OverlayEntry(
      builder: (context) {
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
                      constraints: BoxConstraints(maxHeight: s(300)),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.96),
                        borderRadius: BorderRadius.circular(s(20)),
                        border: Border.all(color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: s(10),
                            offset: Offset(0, s(4)),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: s(8)),
                        shrinkWrap: true,
                        itemCount: filteredSuggestions.length,
                        itemBuilder: (context, index) {
                          final user = filteredSuggestions[index];

                          final String name = user["name"]?.toString() ?? "";

                          final String phone = user["phone"]?.toString() ?? "";

                          return GestureDetector(
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
                              height: s(50),
                              margin: EdgeInsets.symmetric(
                                horizontal: s(10),
                                vertical: s(6),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: s(10)),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F1F1),
                                borderRadius: BorderRadius.circular(s(18)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.lato(
                                            fontSize: s(16),
                                            fontWeight: FontWeight.w400,
                                            color: ColorPalette.textfiledin
                                                .withValues(alpha: .80),
                                          ),
                                        ), SizedBox(width: s(5),),
                                        Text(
                                          "-",
                                          maxLines: 1,
                                          style: GoogleFonts.lato(
                                            fontSize: s(16),
                                            fontWeight: FontWeight.w400,
                                            color: ColorPalette.textfiledin
                                                .withValues(alpha: .80),
                                          ),
                                        ), SizedBox(width: s(5),),
                                        Text(
                                          phone,
                                          style: GoogleFonts.lato(
                                            fontSize: s(16),
                                            fontWeight: FontWeight.w400,
                                            color: ColorPalette.textfiledin
                                                .withValues(alpha: .80),
                                          ),
                                        ),
                                      ],
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
        height: s(52),
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

                  setState(() {});
                },

                onTap: () {
                  _updateOverlay();
                },

                style: GoogleFonts.lato(
                  fontSize: s(16),
                  fontWeight: FontWeight.w400,
                  color: ColorPalette.bottomtext,
                ),

                decoration: InputDecoration(
                  isCollapsed: true,
                  border: InputBorder.none,
                  hintText: "Search by Name / Phone Number",
                  hintStyle: GoogleFonts.lato(
                    fontSize: s(16),
                    color: ColorPalette.textfiled,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
