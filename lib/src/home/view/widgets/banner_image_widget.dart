import 'package:flutter/material.dart';

class BannerImageWidget extends StatelessWidget {
  const BannerImageWidget({
    super.key,
    required this.path,
    required this.height,
    this.label,
  });

  final String path;
  final double height;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Colors.white.withOpacity(0.10)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            Positioned.fill(child: Image.asset(path, fit: BoxFit.cover)),

            if (label != null)
              Positioned(
                top: 8,
                left: 18,
                child: Text(
                  label!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    height: 1.83,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
