import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class ImagePickerUseCase {
  Future<Uint8List> call() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      throw Exception('No image selected.');
    }

    final imageData = await pickedImage.readAsBytes();

    return imageData;
  }
}
