import 'package:flutter/material.dart';

class WaveCardWithCircle extends StatelessWidget {
  const WaveCardWithCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 240,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Wave container
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                width: 300,
                height: 200,
                decoration: const BoxDecoration(
                  color: Color(0xFF031273),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
            ),

            // Stroked circle avatar positioned at the center top
            Positioned(
              top: -40, // half of diameter for overlap
              left: 300 / 2 - 40, // center horizontally
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),
                  color: Colors.grey[300], // background color inside circle
                  image: const DecorationImage(
                    image: AssetImage('assets/profile.jpg'), // optional image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Creates the wave at the top
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height * 0.2);

    var firstControlPoint = Offset(size.width * 0.25, 0);
    var firstEndPoint = Offset(size.width * 0.5, size.height * 0.1);
    path.quadraticBezierTo(
        firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width * 0.75, size.height * 0.2);
    var secondEndPoint = Offset(size.width, 0);
    path.quadraticBezierTo(
        secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
