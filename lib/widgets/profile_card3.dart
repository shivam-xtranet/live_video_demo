import 'package:camera_id_demo_android/widgets/dynamic_image_conainer.dart';
import 'package:flutter/material.dart';

class ProfileCard3 extends StatelessWidget {
  const ProfileCard3({super.key, this.imageUrl, this.filePath});
  final String? imageUrl;
  final String? filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(
            height: 250,
            child: BusinessCardContent(filePath: filePath,),
          ),
        ),
      ),
    );
  }
}

class BusinessCardContent extends StatelessWidget {
  const BusinessCardContent({super.key, this.imageUrl, this.filePath});
  final String? imageUrl;
  final String? filePath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // Left side design element
        Stack(
          children: [
            CustomPaint(
              size: const Size(100, 350),
              painter: ArrowDesignPainter(),
            ),
            
        // Overlapping Blue geometric shape
        // Positioned(
        //   top: 0,
        //   left: 0,
        //   child: Container(
        //     width: 250,
        //     height: 250,
        //     decoration: const BoxDecoration(
        //       color: Color.fromARGB(255, 4, 114, 169),
        //       shape: BoxShape.rectangle,
        //       boxShadow: [
        //         BoxShadow(
        //           color: Color.fromARGB(255, 4, 114, 169),
        //           spreadRadius: 20,
        //           blurRadius: 0,
        //         ),
        //       ],
        //     ),
        //     transform: Matrix4.rotationZ(0.9),
        //   ),
        // ),
            const RotatedBox(
              quarterTurns: 3,
              child: SizedBox(
                height: 100,
                width: 100,
                child: Center(
                  child: Text(
                    'Designer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        
        // Right side with content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 16.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const Text(
                  'Xtranet Technologies Pvt.Ltd',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: DynamicImageContainer(filePath: filePath, imageUrl: imageUrl, circle: false,)),
                  ],
                ),
                const Spacer(),
                const Text(
                  'india : +91-9514873520 : john@xtranet.com:',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ArrowDesignPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Define the points for the main blue parallelogram
    final Path path = Path()
      ..moveTo(0, 0) // Top-left
      ..lineTo(size.width, 0) // Top-right
      ..lineTo(size.width * 0.6, size.height) // Bottom-right (adjusted to make it less wide at bottom)
      ..lineTo(0, size.height) // Bottom-left
      ..close();

    final Paint mainPaint = Paint()
      ..color = const Color(0xFF0D47A1) // Deep blue color
      ..style = PaintingStyle.fill;
    
    canvas.drawPath(path, mainPaint);

    // Define the path for the borders along the slanted edge
    final Path borderPath = Path()
      ..moveTo(size.width, 0) // Start from top-right
      ..lineTo(size.width * 0.6, size.height); // End at bottom-right of the blue shape

    // White border paint
    final Paint whiteBorderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0 // Adjust width as seen in the image
      ..style = PaintingStyle.stroke;

    // Gray border paint, slightly offset
    final Paint greyBorderPaint = Paint()
      ..color = Colors.grey[400]! // Lighter grey for the border
      ..strokeWidth = 1.0 // Thinner grey line
      ..style = PaintingStyle.stroke;

    // Draw the white border
    canvas.drawPath(borderPath, whiteBorderPaint);
    // Draw the grey border, slightly inside for the double border effect
    // This requires a bit of transformation or drawing a slightly smaller path.
    // For simplicity, we draw it on top, but a more complex approach would be needed for a perfect "inner" border.
    canvas.drawPath(borderPath, greyBorderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TrapezoidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width * 0.8, size.height)
      ..lineTo(0, size.height)
      ..close();

    final Paint paint = Paint()
      ..color = const Color(0xFF0D47A1) // Dark blue color
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);

    // Drawing the white and gray border lines
    final Path borderPath = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width * 0.8, size.height);

    final Paint whiteBorderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final Paint greyBorderPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    canvas.drawPath(borderPath, whiteBorderPaint);
    canvas.drawPath(borderPath, greyBorderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}