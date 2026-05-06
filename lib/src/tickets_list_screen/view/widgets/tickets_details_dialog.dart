import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/models/ticket_model.dart';

class TicketDetailsDialog extends StatelessWidget {
  final TicketModel ticket;
  final ScrollController? scrollController;

  const TicketDetailsDialog({
    super.key,
    required this.ticket,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 440;
    double s(double v) => v * scale;

    return Container(
      padding: EdgeInsets.only(
        left: s(16),
        right: s(16),
        top: s(16),
        bottom: MediaQuery.of(context).viewInsets.bottom + s(16),
      ),
      decoration: BoxDecoration(
        color: ColorPalette.whitetext,
        borderRadius: BorderRadius.vertical(top: Radius.circular(s(20))),
      ),

      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ticket Details",
                  style: GoogleFonts.poppins(
                    fontSize: s(18),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, size: s(20)),
                ),
              ],
            ),

            SizedBox(height: s(10)),

            Text(ticket.ticketNumber, style: GoogleFonts.lato(fontSize: s(14))),

            SizedBox(height: s(14)),

            _customerCard(s),

            SizedBox(height: s(16)),

            _technicianCard(s),

            SizedBox(height: s(16)),
            _inspectedImages(s),
          ],
        ),
      ),
    );
  }

  Widget _customerCard(double Function(double) s) {
    return Container(
      padding: EdgeInsets.all(s(14)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ticket.customerName,
                style: GoogleFonts.lato(
                  fontSize: s(18),
                  fontWeight: FontWeight.w500,
                  color: ColorPalette.bottomtext,
                ),
              ),
              _statusBadge(ticket.status, s),
            ],
          ),

          SizedBox(height: s(10)),

          _iconRow(Icons.phone, ticket.phone, s),
          SizedBox(height: s(6)),
          _iconRow(Icons.email, ticket.email, s),
          SizedBox(height: s(6)),
          _iconRow(Icons.location_on, ticket.addressLine1, s),
          SizedBox(height: s(16)),
          Divider(thickness: 1, color: Colors.grey.shade300),
          SizedBox(height: s(16)),
          _panelSection(s),
          SizedBox(height: s(16)),
          Divider(thickness: 1, color: Colors.grey.shade300),
          SizedBox(height: s(16)),
          _issueSection(s),
          SizedBox(height: s(16)),

          _imageSection(s),
        ],
      ),
    );
  }

  Widget _panelSection(double Function(double) s) {
    final panels = ticket.panelId.split(",");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Panel IDs", style: _titleStyle(s)),
        SizedBox(height: s(8)),

        Wrap(
          spacing: s(8),
          runSpacing: s(8),
          children: panels.map((e) => _chip(e, s)).toList(),
        ),
      ],
    );
  }

  Widget _issueSection(double Function(double) s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Issue Details", style: _titleStyle(s)),
            _priorityBadge(ticket.priority, s),
          ],
        ),

        SizedBox(height: s(8)),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• ", style: TextStyle(color: Colors.black)),
            Expanded(
              child: Text(
                ticket.issue,
                style: GoogleFonts.lato(
                  fontSize: s(18),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: s(6)),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            ticket.description,
            style: GoogleFonts.lato(
              fontSize: s(14),
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),

        SizedBox(height: s(12)),

        Row(
          children: [
            Expanded(child: _button(Icons.call, "Call", s)),
            SizedBox(width: s(10)),
            Expanded(child: _button(Icons.location_on, "Direction", s)),
          ],
        ),
      ],
    );
  }

  Widget _imageSection(double Function(double) s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Customer side issue panel image", style: _titleStyle(s)),
        SizedBox(height: s(8)),

        Row(
          children: List.generate(3, (index) {
            return Expanded(
              child: Container(
                height: s(114),
                margin: EdgeInsets.only(right: index == 2 ? 0 : s(8)),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _technicianCard(double Function(double) s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Technician Assigned", style: _titleStyle(s)),
        SizedBox(height: s(8)),

        Container(
          height: s(82),
          width: s(400),
          padding: EdgeInsets.all(s(12)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/ticket/gg_profile.png",
              height: s(22),
               width: s(22),),
              SizedBox(width: s(10)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sharma",
                      style: GoogleFonts.lato(
                        fontSize: s(14),
                        color: ColorPalette.bottomtext,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text("2025-11-14", 
                     style: GoogleFonts.lato(
                        fontSize: s(14),
                        color: ColorPalette.bottomtext,
                        fontWeight: FontWeight.w400,
                      ),),
                  ],
                ),
              ),
              _buttonn(null, "Call", s),
            ],
          ),
        ),
      ],
    );
  }

  Widget _inspectedImages(double Function(double) s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(s(10)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Inspected Site Image", style: _titleStyle(s)),

              SizedBox(height: s(10)),

              Row(
                children: List.generate(3, (index) {
                  return Expanded(
                    child: Container(
                      height: s(114),
                      margin: EdgeInsets.only(right: index == 2 ? 0 : s(8)),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _chip(String text, double Function(double) s) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: s(10), vertical: s(6)),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: GoogleFonts.lato(
          fontSize: s(14),
          color: ColorPalette.textfiledin,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _button(IconData? icon, String text, double Function(double) s) {
    return Container(
      height: s(37),
      width: s(180),
      decoration: BoxDecoration(
        color: Color(0xFF26A7DF).withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon, size: s(17), color: Color(0xFF26A7DF)),
          if (icon != null) SizedBox(width: s(6)),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: s(14),
              fontWeight: FontWeight.w600,
              color: Color(0xFF26A7DF),
            ),
          ),
        ],
      ),
    );
  }

 Widget _buttonn(IconData? icon, String text, double Function(double) s) {
    return Container(
      height: s(40),
      width: s(98),
      decoration: BoxDecoration(
        color: Color(0xFF26A7DF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon, size: s(17), color: Color(0xFF26A7DF)),
          if (icon != null) SizedBox(width: s(6)),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: s(16),
              fontWeight: FontWeight.w600,
              color: ColorPalette.whitetext,
            ),
          ),
        ],
      ),
    );
  }



 

  Widget _iconRow(IconData icon, String text, double Function(double) s) {
    return Row(
      children: [
        Icon(
          icon,
          size: s(15),
          color: ColorPalette.textfiledin.withOpacity(0.60),
        ),
        SizedBox(width: s(6)),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.lato(
              fontSize: s(14),
              fontWeight: FontWeight.w400,
              color: ColorPalette.textfiledin,
            ),
          ),
        ),
      ],
    );
  }

  Widget _statusBadge(String status, double Function(double) s) {
    Color bgColor;
    Color textColor;

    switch (status.toUpperCase()) {
      case "OPEN":
        bgColor = Colors.grey.shade100;
        textColor = Colors.grey;
        break;

      case "IN_PROGRESS":
        bgColor = Colors.orange.shade100;
        textColor = Colors.orange;
        break;

      case "RESOLVED":
      case "CLOSED":
        bgColor = Colors.green.shade100;
        textColor = Colors.green;
        break;

      case "CANCELLED":
        bgColor = Colors.red.shade100;
        textColor = Colors.red;
        break;

      default:
        bgColor = Colors.grey.shade200;
        textColor = Colors.grey;
    }

    return Container(
      height: s(28),
      width: s(90),
      padding: EdgeInsets.symmetric(horizontal: s(10), vertical: s(6)),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        textAlign: TextAlign.center,
        style: GoogleFonts.lato(
          fontSize: s(10),
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  Widget _priorityBadge(String priority, double Function(double) s) {
    Color bgColor;
    Color textColor;

    switch (priority.toUpperCase()) {
      case "LOW":
        bgColor = Colors.green.shade100;
        textColor = Colors.green.shade700;
        break;

      case "MEDIUM":
        bgColor = Colors.orange.shade100;
        textColor = Colors.orange.shade800;
        break;

      case "HIGH":
        bgColor = Colors.red.shade100;
        textColor = Colors.red.shade700;
        break;

      case "CRITICAL":
        bgColor = Colors.red.shade300;
        textColor = Colors.white;
        break;

      default:
        bgColor = Colors.grey.shade200;
        textColor = Colors.grey.shade700;
    }

    return Container(
      height: s(28),
      width: s(90),
      padding: EdgeInsets.symmetric(horizontal: s(10)),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        priority.toUpperCase(),
        textAlign: TextAlign.center,
        style: GoogleFonts.lato(
          fontSize: s(10),
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  TextStyle _titleStyle(double Function(double) s) {
    return GoogleFonts.lato(fontSize: s(14), fontWeight: FontWeight.w600);
  }
}
