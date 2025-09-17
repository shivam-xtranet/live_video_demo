import 'dart:core';

import 'package:camera_id_demo_android/widgets/dynamic_image_conainer.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, this.imageUrl, this.filePath});
  final String? imageUrl;
  final String? filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top section with background shapes
              _buildTopSection(),
              // Profile image, name, and job title
              _buildProfileDetails(),
              const SizedBox(height: 10),
              // Contact information
              _buildContactInfo(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Stack(
      children: [
        // Blue background container
        Container(
          height: 140,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 2, 85, 126),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 2, 85, 126),
              Color.fromARGB(255, 1, 142, 137),
              Color.fromARGB(255, 4, 114, 169)
            ])
          ),
        ),
        // Overlapping Teal geometric shape
        // Positioned(
        //   top: 0,
        //   left: 0,
        //   child: Container(
        //     width: 150,
        //     height: 150,
          
        //     decoration: const BoxDecoration(
        //       color: Color.fromARGB(255, 1, 142, 137),
        //       shape: BoxShape.rectangle,
        //       boxShadow: [
        //         BoxShadow(
        //           color: Color.fromARGB(255, 1, 142, 137),
        //           spreadRadius: 20,
        //           blurRadius: 40,
        //         ),
        //       ],
        //     ),
        //     transform: Matrix4.rotationZ(-0.4),
        //   ),
        // ),
        // // Overlapping Blue geometric shape
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
        //           blurRadius: 40,
        //         ),
        //       ],
        //     ),
        //     transform: Matrix4.rotationZ(0.6),
        //   ),
        // ),
        // Company name and tagline text
        const Positioned(
          top: 40,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Xtranet Technologies Pvt.Ltd',
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              // Text(
              //   'TAGLINE GOES HERE',
              //   style: TextStyle(color: Colors.white70, fontSize: 12),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileDetails() {
    return Column(
      children: [
        // Profile image
        Transform.translate(
          offset: const Offset(0, -60), // Lifts the image up
          child: DynamicImageContainer(filePath: filePath, imageUrl: imageUrl),
        ),
        // Name and job title
        Transform.translate(
          offset: const Offset(0, -50),
          child: const Column(
            children: [
              Text(
                'JOHN DOE',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'DESIGNER',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildInfoRow('ID NO', '000 000 000 221'),
          const SizedBox(height: 15),
          _buildInfoRow('EMAIL', 'john@xtranet.com'),
          const SizedBox(height: 15),
          _buildInfoRow('PHONE', '+00 001 231 589'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ),
        const Text(':', style: TextStyle(color: Colors.black54)),
        const SizedBox(width: 10),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
