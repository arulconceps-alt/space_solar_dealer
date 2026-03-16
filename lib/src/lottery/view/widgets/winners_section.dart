import 'package:flutter/material.dart';

class WinnersSection extends StatelessWidget {
  const WinnersSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive scaling based on device width
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scale = (screenWidth / 375).clamp(0.9, 1.1);

    return Center(
      child: Container(
        width: 343 * scale,
        height: 196 * scale,
        decoration: ShapeDecoration(
          color: const Color(0xFF24232A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8 * scale),
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // --- CUSTOM SVG-STYLE HEADER ---
            Positioned(
              top: 0,
              left: (343 * scale - 214 * scale) / 2,
              child: CustomPaint(
                size: Size(214 * scale, 32 * scale),
                painter: HeaderTabPainter(),
                child: Container(
                  width: 214 * scale,
                  height: 32 * scale,
                  alignment: Alignment.center,
                  child: Text(
                    'Yesterday Winners',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFDFC45C),
                      fontSize: 12 * scale,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            // --- WINNERS TILES (LEFT COLUMN) ---
            Positioned(
              left: 28 * scale,
              top: 57 * scale,
              child: _buildWinnerTile(scale),
            ),
            Positioned(
              left: 28 * scale,
              top: 101 * scale,
              child: _buildWinnerTile(scale),
            ),
            Positioned(
              left: 28 * scale,
              top: 145 * scale,
              child: _buildWinnerTile(scale),
            ),

            // --- WINNERS TILES (RIGHT COLUMN) ---
            Positioned(
              left: 182 * scale,
              top: 57 * scale,
              child: _buildWinnerTile(scale),
            ),
            Positioned(
              left: 182 * scale,
              top: 101 * scale,
              child: _buildWinnerTile(scale),
            ),
            Positioned(
              left: 182 * scale,
              top: 145 * scale,
              child: _buildWinnerTile(scale),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWinnerTile(double scale) {
    return Container(
      width: 134 * scale,
      height: 36 * scale,
      child: Stack(
        children: [
          // Avatar
          Positioned(
            left: 0,
            top: 0.88,
            child: Container(
              width: 35.12 * scale,
              height: 35.12 * scale,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage("assets/images/icons/state_lottery_01.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          // Info Text
          Positioned(
            left: 43 * scale,
            top: 0,
            child: _winnerInfoText('Player id : 125****', Colors.white, scale),
          ),
          Positioned(
            left: 43 * scale,
            top: 12 * scale,
            child: _winnerInfoText(
              'Location : Coimbatore',
              const Color(0xFF9F9F9F),
              scale,
            ),
          ),
          Positioned(
            left: 43 * scale,
            top: 25 * scale,
            child: _winnerInfoText('₹40,000', Colors.white, scale),
          ),
        ],
      ),
    );
  }

  Widget _winnerInfoText(String label, Color color, double scale) {
    return Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: 8.55 * scale,
        fontStyle: FontStyle.italic,
        fontFamily: 'DM Sans',
        fontWeight: FontWeight.w500,
        height: 1.3,
      ),
    );
  }
}

// Custom Painter for the background #313038 header shape
class HeaderTabPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFF313038)
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    // Smooth curves for the SVG "cup" look
    path.quadraticBezierTo(
      size.width * 0.95,
      size.height * 0.1,
      size.width * 0.88,
      size.height * 0.8,
    );
    path.quadraticBezierTo(
      size.width * 0.85,
      size.height,
      size.width * 0.75,
      size.height,
    );
    path.lineTo(size.width * 0.25, size.height);
    path.quadraticBezierTo(
      size.width * 0.15,
      size.height,
      size.width * 0.12,
      size.height * 0.8,
    );
    path.quadraticBezierTo(size.width * 0.05, size.height * 0.1, 0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
