import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';
import 'package:space_solar_dealer/src/common/models/ticket_model.dart';
import 'package:space_solar_dealer/src/common/models/ticket_timeline_model.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/widgets/customer_sign_card.dart';
import 'package:space_solar_dealer/src/tickets_list_screen/view/widgets/tickets_timeline.dart';
import 'package:url_launcher/url_launcher.dart';

class TicketDetailsDialog extends StatelessWidget {
  final TicketModel ticket;
  final ScrollController? scrollController;

  const TicketDetailsDialog({
    super.key,
    required this.ticket,
    this.scrollController,
  });

  // Signature: from technicianAttachments only
  String? _getSignatureUrl() {
    try {
      return ticket.technicianAttachments.firstWhere(
        (url) => Uri.parse(url).path.contains('sig_'),
      );
    } catch (_) {
      return null;
    }
  }

  // Technician images without signature
  List<String> _getTechnicianImages() {
    return ticket.technicianAttachments
        .where((url) => !Uri.parse(url).path.contains('sig_'))
        .toList();
  }

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return "-";
    final parsed = DateTime.tryParse(date);
    if (parsed == null) return "-";
    return "${parsed.day.toString().padLeft(2, '0')}-"
        "${parsed.month.toString().padLeft(2, '0')}-"
        "${parsed.year}";
  }

  List<TimelineItemModel> _buildTimeline() {
    final List<TimelineItemModel> items = [];

    DateTime parseDate(String date) {
      return DateTime.tryParse(date)?.toLocal() ?? DateTime(2000);
    }

    /// find technician for current status time
    String getTechnicianName(DateTime statusTime) {
      String technician = "";

      final assignments = [...ticket.assignmentHistory];

      assignments.sort(
        (a, b) =>
            parseDate(a["changedAt"]).compareTo(parseDate(b["changedAt"])),
      );

      for (final assign in assignments) {
        final assignTime = parseDate(assign["changedAt"]);

        if (assignTime.isBefore(statusTime) ||
            assignTime.isAtSameMomentAs(statusTime)) {
          technician = (assign["toAssignedToName"] ?? "").toString();
        }
      }

      return technician;
    }

    for (final history in ticket.statusHistory) {
      final toStatus = (history["toStatus"] ?? "").toString();

      final changedAt = history["changedAt"] ?? "";

      final dateTime = parseDate(changedAt);

      String label = toStatus;
      String title = "Status Changed";
      Color color = Colors.grey;

      switch (toStatus) {
        case "OPEN":
          title = "Ticket Created";
          label = "Open";
          color = Colors.grey;
          break;

        case "ASSIGNED":
          title = "Ticket Assigned";
          label = "Assigned";
          color = Colors.blueAccent;
          break;

        case "ACCEPT":
          title = "Ticket Accepted";
          label = "Accepted";
          color = Colors.blueAccent;
          break;

        case "IN_PROGRESS":
          title = "Work Started";
          label = "In Progress";
          color = Colors.orange;
          break;

        case "RE_SCHEDULED":
          title = "Ticket Re-Scheduled";
          label = "Re-Scheduled";
          color = Colors.blue;
          break;

        case "COMPLETE":
          title = "Work Completed";
          label = "Completed";
          color = Colors.green;
          break;

        case "CLOSED":
          title = "Ticket Closed";
          label = "Closed";
          color = Colors.green;
          break;

        default:
          title = toStatus;
          label = toStatus;
          color = Colors.grey;
      }

      /// OPEN ku technician show panna vendaam
      String? technicianName;

      if (toStatus != "OPEN") {
        technicianName = getTechnicianName(dateTime);

        if (technicianName.isEmpty) {
          technicianName = null;
        }
      }

      items.add(
        TimelineItemModel(
          title: title,
          statusLabel: label,
          value: _formatDateTime(changedAt),
          dateTime: dateTime,
          statusColor: color,

          reason: history["reason"],
          changedByName: history["changedByName"],

          toName: technicianName,

          workedMinutes: toStatus == "IN_PROGRESS"
              ? ticket.totalWorkedInMinutes
              : null,

          revisitDate: toStatus == "RE_SCHEDULED" && ticket.revisitDate != null
              ? _formatDateTime(ticket.revisitDate!)
              : null,
        ),
      );
    }

    items.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return items;
  }

  String _formatDateTime(String dateStr) {
    final parsed = DateTime.tryParse(dateStr)?.toLocal();
    if (parsed == null) return "-";
    final hour = parsed.hour > 12 ? parsed.hour - 12 : parsed.hour;
    final amPm = parsed.hour >= 12 ? "PM" : "AM";
    final monthNames = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return "${monthNames[parsed.month - 1]} ${parsed.day}, ${parsed.year}, "
        "${hour.toString().padLeft(2, '0')}:${parsed.minute.toString().padLeft(2, '0')} $amPm";
  }

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
            _customerCard(s, context),
            SizedBox(height: s(16)),
            _technicianCard(s),
            SizedBox(height: s(16)),
            _inspectedImages(s),
            SizedBox(height: s(16)),
            //CustomerSignatureCard(signatureImage: "", scale: scale),
            CustomerSignatureCard(
              signatureImage: _getSignatureUrl(),
              scale: scale,
            ),
            SizedBox(height: s(16)),
            TicketTimelineWidget(scale: scale, items: _buildTimeline()),
          ],
        ),
      ),
    );
  }

  Widget _customerCard(double Function(double) s, BuildContext context) {
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
          _panelIdsSection(s),
          Divider(thickness: 1, color: Colors.grey.shade300),
          SizedBox(height: s(16)),
          SizedBox(height: s(16)),
          _issueSection(s),
          SizedBox(height: s(16)),
          _imageSection(s, context),
        ],
      ),
    );
  }

  Widget _panelIdsSection(double Function(double) s) {
    final panelIds = ticket.panelId.isNotEmpty
        ? ticket.panelId
              .split(",")
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList()
        : <String>[];

    if (panelIds.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Panel IDs",
          style: GoogleFonts.lato(fontSize: s(16), fontWeight: FontWeight.w600),
        ),

        SizedBox(height: s(12)),

        Wrap(
          spacing: s(12),
          runSpacing: s(10),
          children: panelIds.map((id) {
            return Container(
              width: s(160),
              padding: EdgeInsets.symmetric(horizontal: s(12), vertical: s(10)),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                id,
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontSize: s(14),
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            );
          }).toList(),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: s(8)),
              width: s(8),
              height: s(8),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),

            SizedBox(width: s(10)),

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
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  final phone = ticket.phone;

                  if (phone.isNotEmpty) {
                    await _makeCall(phone);
                  }
                },
                child: _button(Icons.call, "Call", s),
              ),
            ),

            SizedBox(width: s(10)),

            Expanded(
              child: GestureDetector(
                onTap: () async {
                  final address = ticket.addressLine1;

                  if (address.isNotEmpty) {
                    await _openDirection(address);
                  }
                },
                child: _button(Icons.location_on, "Direction", s),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _openDirection(String address) async {
    final Uri googleMapUrl = Uri.https('www.google.com', '/maps/search/', {
      'api': '1',
      'query': address,
    });

    try {
      await launchUrl(googleMapUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint("Cannot open maps: $e");
    }
  }

  Widget _imageSection(double Function(double) s, BuildContext context) {
    final displayImages = ticket.dealerAttachments;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Customer side issue panel image",
          style: GoogleFonts.poppins(
            fontSize: s(16),
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: s(12)),
        SizedBox(
          height: s(114),
          child:
              displayImages
                  .isEmpty // ← ticket.attachments → displayImages
              ? ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (_, __) => SizedBox(width: s(8)),
                  itemBuilder: (_, index) {
                    return Container(
                      width: s(114),
                      height: s(114),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEDED),
                        borderRadius: BorderRadius.circular(s(10)),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.image_outlined,
                        color: Colors.grey.shade400,
                        size: s(28),
                      ),
                    );
                  },
                )
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: displayImages.length,
                  separatorBuilder: (_, __) => SizedBox(width: s(8)),
                  itemBuilder: (_, index) {
                    final url = displayImages[index];
                    return GestureDetector(
                      onTap: () => _showImageFullScreen(context, url, s),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(s(10)),
                        child: CachedNetworkImage(
                          imageUrl: url,
                          width: s(114),
                          height: s(114),
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(
                            width: s(114),
                            height: s(114),
                            color: const Color(0xFFEDEDED),
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFF26A7DF),
                            ),
                          ),
                          errorWidget: (_, __, ___) => Container(
                            width: s(114),
                            height: s(114),
                            color: const Color(0xFFEDEDED),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _showImageFullScreen(
    BuildContext context,
    String url,
    double Function(double) s,
  ) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                child: CachedNetworkImage(
                  imageUrl: url,
                  fit: BoxFit.contain,
                  placeholder: (_, __) => Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                  errorWidget: (_, __, ___) =>
                      Icon(Icons.broken_image, color: Colors.white, size: 48),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 16,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.close, color: Colors.white, size: 28),
              ),
            ),
          ],
        ),
      ),
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
              Image.asset(
                "assets/images/ticket/gg_profile.png",
                height: s(22),
                width: s(22),
              ),
              SizedBox(width: s(10)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ticket.assignedToName.isNotEmpty
                          ? ticket.assignedToName
                          : "Not Assigned",
                      style: GoogleFonts.lato(
                        fontSize: s(14),
                        color: ColorPalette.bottomtext,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "${ticket.createdAt.day.toString().padLeft(2, '0')}-"
                      "${ticket.createdAt.month.toString().padLeft(2, '0')}-"
                      "${ticket.createdAt.year}",
                      style: GoogleFonts.lato(
                        fontSize: s(14),
                        color: ColorPalette.bottomtext,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  final phone = ticket.assignedTo?.phone ?? "";
                  if (phone.isNotEmpty) {
                    _makeCall(phone);
                  }
                },
                child: _buttonn("Call", s),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _makeCall(String phone) async {
    final Uri uri = Uri(scheme: 'tel', path: phone);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Cannot launch dialer");
    }
  }

  // _inspectedImages → uses technicianAttachments (excluding signature)
  Widget _inspectedImages(double Function(double) s) {
    final techImages = _getTechnicianImages();

    return Container(
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

          SizedBox(
            height: s(114),
            child: techImages.isEmpty
                ? Row(
                    children: List.generate(3, (index) {
                      return Expanded(
                        child: Container(
                          height: s(114),
                          margin: EdgeInsets.only(right: index == 2 ? 0 : s(8)),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDEDED),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }),
                  )
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: techImages.length,
                    separatorBuilder: (_, __) => SizedBox(width: s(8)),
                    itemBuilder: (context, index) {
                      final imageUrl = techImages[index];

                      return GestureDetector(
                        onTap: () {
                          _openFullScreenImage(context, imageUrl);
                        },
                        child: _networkImage(imageUrl, s),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _openFullScreenImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (_) {
        return Stack(
          children: [
            Center(
              child: InteractiveViewer(
                child: Image.network(imageUrl, fit: BoxFit.contain),
              ),
            ),

            Positioned(
              top: 40,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: Icon(Icons.close, color: ColorPalette.textfiledin),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _placeholderBox(double Function(double) s) {
    return Container(
      width: s(114),
      height: s(114),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDED),
        borderRadius: BorderRadius.circular(s(10)),
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.image_outlined,
        color: Colors.grey.shade400,
        size: s(28),
      ),
    );
  }

  Widget _networkImage(String url, double Function(double) s) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(s(10)),
      child: CachedNetworkImage(
        imageUrl: url,
        width: s(114),
        height: s(114),
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(
          width: s(114),
          height: s(114),
          color: const Color(0xFFEDEDED),
          alignment: Alignment.center,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            color: Color(0xFF26A7DF),
          ),
        ),
        errorWidget: (_, __, ___) => Container(
          width: s(114),
          height: s(114),
          color: const Color(0xFFEDEDED),
          alignment: Alignment.center,
          child: const Icon(Icons.broken_image, color: Colors.grey),
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

  Widget _buttonn(String text, double Function(double) s) {
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
      case "ASSIGNED":
        bgColor = Colors.red.shade100;
        textColor = Colors.blueAccent;
        break;
      case "IN_PROGRESS":
        bgColor = Colors.orange.shade100;
        textColor = Colors.orange;
        break;
      case "COMPLETE":
      case "CLOSED":
        bgColor = Colors.green.shade100;
        textColor = Colors.green;
        break;
      default:
        bgColor = Colors.grey.shade200;
        textColor = Colors.grey;
    }
    return Container(
      height: s(28),
      width: s(90),
      padding: EdgeInsets.symmetric(horizontal: s(10), vertical: s(8)),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        textAlign: TextAlign.center,
        style: GoogleFonts.lato(
          fontSize: status == "RE_SCHEDULED" ? s(8.5) : s(10),
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
        textColor = Colors.orange;
        break;
      case "HIGH":
        bgColor = Colors.red.shade100;
        textColor = Colors.red.shade700;
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
    return GoogleFonts.lato(fontSize: s(16), fontWeight: FontWeight.w600);
  }
}
