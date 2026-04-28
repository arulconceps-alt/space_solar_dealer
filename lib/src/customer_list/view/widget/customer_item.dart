import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/models/customer_model.dart';

class CustomerItem extends StatelessWidget {
  final CustomerModel customer;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onTap;

  const CustomerItem({
    super.key,
    required this.customer,
    required this.onTap,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;
    double s(double v) => v * scale;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.only(
          topLeft: isFirst ? Radius.circular(s(10)) : Radius.zero,
          topRight: isFirst ? Radius.circular(s(10)) : Radius.zero,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: isFirst ? Radius.circular(s(10)) : Radius.zero,
            topRight: isFirst ? Radius.circular(s(10)) : Radius.zero,
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: s(5),
              sigmaY: s(5),
            ),
            child: Container(
              height: s(70),
              width: s(400),
              padding: EdgeInsets.symmetric(horizontal: s(10), vertical: s(10)),
              decoration: BoxDecoration(
                color: ColorPalette.whitetext.withOpacity(0.50),
                border: Border.all(
                  color: ColorPalette.whitetext,
                  width: s(1),
                ),
              ),
              child: Row(
                children: [
                  /// AVATAR
                  Container(
                    width: s(50),
                    height: s(50),
                    decoration: BoxDecoration(
                      color: ColorPalette.whitetext.withOpacity(0.50),
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorPalette.whitetext),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      customer.name.isNotEmpty ? customer.name[0] : "?",
                      style: GoogleFonts.lato(
                        fontSize: s(24),
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000),
                      ),
                    ),
                  ),

                  SizedBox(width: s(12)),

                  /// TEXT
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer.name,
                          style: GoogleFonts.lato(
                            fontSize: s(16),
                            fontWeight: FontWeight.w400,
                            color: ColorPalette.bottomtext,
                          ),
                        ),
                        SizedBox(height: s(4)),
                        Text(
                          customer.phone,
                          style: GoogleFonts.lato(
                            fontSize: s(14),
                            color: ColorPalette.textfiledin.withValues(alpha: .80),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// VIEW ICON
                  InkWell(
                    onTap: () {
                      context.push(
                        '/customer_detail',
                        extra: customer,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(s(6)),
                      child: Image.asset(
                        "assets/images/customer/eye_icon.png",
                        width: s(23.9),
                        height: s(23.9),
                      ),
                    ),
                  ),

                  SizedBox(width: s(12)),

                  /// EDIT ICON
                  InkWell(
                    onTap: () {
                      context.push(
                        '/customer_detail',
                        extra: customer,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(s(6)),
                      child: Image.asset(
                        "assets/images/customer/edit_icon.png",
                        width: s(23.9),
                        height: s(23.9),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    /*return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: isFirst ? Radius.circular(s(10)) : Radius.zero,
          topRight: isFirst ? Radius.circular(s(10)) : Radius.zero,

        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: s(5), 
            sigmaY: s(5), 
          ),
          child: Container(
            height: s(70),
            width: s(400),
            padding: EdgeInsets.symmetric(horizontal: s(10), vertical: s(10)),
            decoration: BoxDecoration(
              color: ColorPalette.whitetext.withOpacity(0.50),
              border: Border.all(
                color: ColorPalette.whitetext,
                width: s(1)
              )
            ),
            child: Row(
              children: [
                /// AVATAR
                Container(
                  width: s(50),
                  height: s(50),
                  decoration: BoxDecoration(
                    color: ColorPalette.whitetext.withOpacity(0.50),
                    shape: BoxShape.circle,
                    border: Border.all(color: ColorPalette.whitetext),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    customer.name.isNotEmpty ? customer.name[0] : "?",
                    style: GoogleFonts.lato(
                      fontSize: s(24),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ),

                SizedBox(width: s(12)),

                /// TEXT
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customer.name,
                        style: GoogleFonts.lato(
                          fontSize: s(16),
                          fontWeight: FontWeight.w400,
                          color: ColorPalette.bottomtext,
                        ),
                      ),
                       SizedBox(height: s(4)),
                      Text(
                        customer.phone,
                        style: GoogleFonts.lato(
                          fontSize: s(14),
                          fontWeight: FontWeight.w400,
                          color: ColorPalette.textfiledin.withValues(alpha: .80),
                        ),
                      ),
                    ],
                  ),
                ),

                /// VIEW ICON
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(s(6)),
                    onTap: () {
                      context.push('/customer_detail', extra: customer);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(s(4)), // better tap area
                      child: Image.asset(
                        "assets/images/customer/eye_icon.png",
                        width: s(23.9),
                        height: s(23.9),
                        color: ColorPalette.textfiledin.withValues(alpha: .80),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: s(24)),

                /// EDIT ICON
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(s(6)),
                    onTap: () {
                      context.push('/editCustomer');
                    },
                    child: Padding(
                      padding: EdgeInsets.all(s(4)),
                      child: Image.asset(
                        "assets/images/customer/edit_icon.png",
                        width: s(23.9),
                        height: s(23.9),
                        color: ColorPalette.textfiledin.withOpacity(0.80),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );*/
  }
}