import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ProfileImagePickerUseCase {
  Future<File> call() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    return File(pickedImage!.path);
  }
}
