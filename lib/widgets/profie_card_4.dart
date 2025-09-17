import 'dart:io';

import 'package:camera_id_demo_android/widgets/dynamic_image_conainer.dart';
import 'package:flutter/material.dart';

class ProfieCard4 extends StatelessWidget {
  const ProfieCard4({super.key, this.imageUrl, this.filePath});
  final String? imageUrl;
  final String? filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: SizedBox(height: 250, child: imageCard()),
        ),
      ),
    );
  }

  Widget imageCard() {
    return Stack(
      children: [
        Image.asset('assets/card_image.png'),
        Align(
          alignment: Alignment.centerRight,
          child: Transform.translate(
            offset: const Offset(-10, 0), // Move the image left
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(30),
              child: DynamicImageContainer(
                filePath: filePath,
                imageUrl: imageUrl,
                circle: false,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
