import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class CustomImagePicker {
  static Future<String?> pickImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (pickedFile != null) {
      try {
        final File image = File(pickedFile.path);

        // Optional: check file exists
        if (await image.exists()) {
          return image.path;
        } else {
          log("Image file does not exist");
        }
      } catch (e) {
        log("Error loading image: $e");
      }
    }
    return null;
  }
}
