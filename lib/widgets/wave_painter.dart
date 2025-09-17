import 'package:flutter/material.dart';

class WaveClipperChnge extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.3);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.15,
      size.width * 0.5,
      size.height * 0.3,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.45,
      size.width,
      size.height * 0.3,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class WaveStrokePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = WaveClipperChnge().getClip(size);
    final paintStroke = Paint()
      ..color = Colors.white // stroke color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, paintStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WaveHeader extends StatelessWidget {
  const WaveHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Blue background clipped to wave
          ClipPath(
            clipper: WaveClipperChnge(),
            child: Container(
              height: 250,
              color: const Color(0xFF031273),
            ),
          ),
          // Stroke on top
          Positioned.fill(
            child: CustomPaint(
              painter: WaveStrokePainter(),
            ),
          ),
          // Circle on top center
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white, // inner fill color
                  border: Border.all(
                    color: const Color(0xFF031273), // stroke color
                    width: 4,
                  ),
                ),
                child: const Icon(Icons.person, size: 40, color: Color(0xFF031273)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
