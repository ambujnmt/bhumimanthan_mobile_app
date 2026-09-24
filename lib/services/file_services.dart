import 'dart:io';

// import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class FileServices {
  static final ImagePicker _picker = ImagePicker();

  /// PICK IMAGE FROM GALLERY
  static Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image == null) return null;

      return File(image.path);
    } catch (e) {
      return null;
    }
  }

  /// PICK IMAGE FROM CAMERA
  static Future<File?> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
      );

      if (image == null) return null;

      return File(image.path);
    } catch (e) {
      return null;
    }
  }

  /// PICK FILE
  // static Future<File?> pickFile() async {
  //   try {
  //     FilePickerResult? result = await FilePicker.pickFiles(
  //       allowMultiple: false,
  //     );

  //     if (result == null) return null;

  //     final path = result.files.single.path;

  //     if (path == null) return null;

  //     return File(path);
  //   } catch (e) {
  //     return null;
  //   }
  // }
}
