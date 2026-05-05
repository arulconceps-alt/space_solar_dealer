import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PanelRegistrationCard extends StatelessWidget {
  final double scale;

  // ✅ ADD THIS (to return scanned value)
  final Function(String) onScanResult;

  const PanelRegistrationCard({
    super.key,
    required this.scale,
    required this.onScanResult,
  });

  @override
  Widget build(BuildContext context) {
    double s(double v) => v * scale;

    return Container(
      width: s(400),
      height: s(436),
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
            "Register Panel",
            style: GoogleFonts.poppins(
              fontSize: s(18),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: s(33)),
          Center(
            child: Column(
              children: [
                DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    color: const Color(0xFF000000).withOpacity(0.50),
                    strokeWidth: 1,
                    dashPattern: const [6, 4],
                    radius: Radius.circular(s(10)),
                  ),
                  child: Container(
                    width: s(180),
                    height: s(180),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.50),
                      borderRadius: BorderRadius.circular(s(10)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(s(40)),
                      child: Image.asset(
                        "assets/images/new_register/qr_scan.png",
                        width: s(100),
                        height: s(100),
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.qr_code_scanner,
                          size: s(80),
                          color: const Color(0xFF484848),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: s(32)),
                Text(
                  'Position QR code within the frame',
                  style: GoogleFonts.lato(
                    fontSize: s(14),
                    color: const Color(0xCC484848),
                  ),
                ),
                SizedBox(height: s(32)),
              ],
            ),
          ),

          // ✅ SCAN BUTTON FIXED
          _buildBlueButton("Scan", scale, () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => QRScannerScreen(
                  onScan: (code) {
                    print("✅ SCANNED RESULT: $code");

                    // send to parent
                    onScanResult(code);
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBlueButton(String text, double scale, VoidCallback onTap) {
    double s(double v) => v * scale;
    return Material(
      color: const Color(0xFF26A7DF),
      borderRadius: BorderRadius.circular(s(10)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(s(10)),
        child: Container(
          height: s(50),
          alignment: Alignment.center,
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: s(16),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// ✅ QR SCANNER SCREEN (FIXED)
// ==========================================
class QRScannerScreen extends StatelessWidget {
  final Function(String) onScan;

  const QRScannerScreen({
    super.key,
    required this.onScan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan QR")),
      body: MobileScanner(
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;

          for (final barcode in barcodes) {
            final String? code = barcode.rawValue;

            if (code != null) {
              print("📷 SCANNED: $code");

              onScan(code);

              Navigator.pop(context);
              break;
            }
          }
        },
      ),
    );
  }
}