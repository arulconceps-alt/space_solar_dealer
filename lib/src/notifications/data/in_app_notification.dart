import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:space_solar_dealer/src/app/color_palette.dart';

class InAppNotificationBox extends StatelessWidget {

  final String title;
  final String body;
  final String? imageUrl;

  const InAppNotificationBox({
    super.key,
    required this.title,
    required this.body,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {

    return Material(
      color: Colors.transparent ,

      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,

          padding: const EdgeInsets.all(18),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.circular(22),

            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black12,
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [

              if (imageUrl != null)
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(16),

                  child: Image.network(
                    imageUrl!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

              const SizedBox(height: 16),

              Text(
                title,

                textAlign: TextAlign.center,

                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                body,

                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 18),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorPalette.background,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                ),

                child: Text(
                  "OK",

                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                   color: ColorPalette.whitetext
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}