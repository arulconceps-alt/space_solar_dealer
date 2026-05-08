import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class PanelRegistrationCard extends StatelessWidget {
  final double scale;
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
                    color: Colors.black.withOpacity(0.5),
                    strokeWidth: 1,
                    dashPattern: const [6, 4],
                    radius: Radius.circular(s(10)),
                  ),

                  child: Container(
                    width: s(180),
                    height: s(180),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(s(10)),
                    ),

                    child: Padding(
                      padding: EdgeInsets.all(s(40)),
                      child: Image.asset(
                        "assets/images/new_register/qr_scan.png",
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) {
                          return Icon(
                            Icons.qr_code_scanner,
                            size: s(80),
                            color: const Color(0xFF484848),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(height: s(32)),

                Text(
                  'Position QR / Barcode within the frame',
                  style: GoogleFonts.lato(
                    fontSize: s(14),
                    color: const Color(0xCC484848),
                  ),
                ),

                SizedBox(height: s(32)),
              ],
            ),
          ),

          /// SCAN BUTTON
          _buildBlueButton(
            "Scan",
            scale,
            () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QRScannerScreen(
                    onScan: (code) {
                      debugPrint("✅ SCANNED RESULT: $code");

                      onScanResult(code);
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBlueButton(
    String text,
    double scale,
    VoidCallback onTap,
  ) {
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

class QRScannerScreen extends StatefulWidget {
  final Function(String) onScan;

  const QRScannerScreen({
    super.key,
    required this.onScan,
  });

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,

    /// ALL TYPES SUPPORT
    formats: [
      BarcodeFormat.qrCode,
      BarcodeFormat.code128,
      BarcodeFormat.code39,
      BarcodeFormat.code93,
      BarcodeFormat.ean13,
      BarcodeFormat.ean8,
      BarcodeFormat.upcA,
      BarcodeFormat.upcE,
      BarcodeFormat.itf,
      BarcodeFormat.pdf417,
      BarcodeFormat.aztec,
      BarcodeFormat.dataMatrix,
      BarcodeFormat.codabar,
    ],
  );

  bool isScanned = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Scan QR / Barcode"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),

      body: Stack(
        children: [
          MobileScanner(
            controller: controller,

            onDetect: (capture) {
              if (isScanned) return;

              final List<Barcode> barcodes = capture.barcodes;

              for (final barcode in barcodes) {
                final String? code = barcode.rawValue;

                if (code != null && code.isNotEmpty) {
                  isScanned = true;

                  debugPrint("📷 SCANNED: $code");

                  widget.onScan(code);

                  Navigator.pop(context);

                  break;
                }
              }
            },
          ),

          /// SCAN BOX UI
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Text(
              "Scan any QR or Barcode",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}