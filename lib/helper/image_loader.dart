import 'package:flutter/material.dart';

class ImageLoader {
  static ImageProvider getImageProvider(String imageUrl, {String defaultImagePath = 'assets/logo.png'}) {

    try {
      // Attempt to create a NetworkImage with the provided URL
      if (imageUrl.isEmpty) {
        // Return AssetImage for the default image if the imageUrl is empty
        return AssetImage(defaultImagePath);
      }
      return NetworkImage(imageUrl);
    } catch (e) {
      // If an error occurs (e.g., invalid URL), return a AssetImage for the default image
      debugPrint('Error loading image: $e');
      return AssetImage(defaultImagePath);
    }
  }
}
