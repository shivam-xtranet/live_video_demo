import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DynamicImageContainer extends StatelessWidget {
  final String? imageUrl;
  final String? filePath;
  final bool circle;

  const DynamicImageContainer({
    super.key,
    this.imageUrl,
    this.filePath,
    this.circle = true
  });

  // A helper method to determine which ImageProvider to use
  ImageProvider getImageProvider() {
    // 1. Check for a valid network image URL
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CachedNetworkImageProvider(imageUrl!);
    }
    // 2. Check for a valid file path
    else if (filePath != null && filePath!.isNotEmpty) {
      final file = File(filePath!);
      if (file.existsSync()) {
        return FileImage(file);
      }
    }
    // 3. Fallback to a placeholder asset image
    return const AssetImage('assets/placeholder.png');
  }

  // A helper method to provide a child widget for the placeholder
  Widget getPlaceholderChild() {
    // Only show the icon if no network or file image is available
    if ((imageUrl == null || imageUrl!.isEmpty) && (filePath == null || filePath!.isEmpty)) {
      return const Center(
        child: Icon(
          Icons.image,
          size: 60,
          color: Colors.grey,
        ),
      );
    }
    // Otherwise, return an empty container
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 219, 226, 233),
        shape: circle ? BoxShape.circle : BoxShape.rectangle,
        border: Border.all(color: Colors.white, width: 5),
        image: DecorationImage(
          image: getImageProvider(),
          fit: BoxFit.cover,
        ),
      ),
      child: getPlaceholderChild(),
    );
  }
}