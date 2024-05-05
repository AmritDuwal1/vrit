import 'dart:typed_data';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';


Future<File?> compressImage(String imagePath, {int quality = 70}) async {
  // Compress the image
  Uint8List? compressedImageData = await FlutterImageCompress.compressWithFile(
    imagePath,
    quality: quality,
  );

  // Check if compression was successful
  if (compressedImageData != null) {
    try {
      // Write the compressed image data to a temporary file
      final tempFile = File('${Directory.systemTemp.path}/compressed_image_${DateTime.now().millisecondsSinceEpoch}.jpg');
      await tempFile.writeAsBytes(compressedImageData);

      // Return the File object
      return tempFile;
    } catch (e) {
      // Handle any errors that occur during file writing
      print('Error writing compressed image file: $e');
      return null;
    }
  } else {
    // Return null if compression fails
    return null;
  }
}
