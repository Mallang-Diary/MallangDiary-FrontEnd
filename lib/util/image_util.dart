import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtil {
  static Future<Uint8List> imageToUint8List(String imagePath) async {
    final bytes = await rootBundle.load(imagePath);
    return bytes.buffer.asUint8List();
  }

  static Image uint8ListToAssetImage(Uint8List bytes) {
    return Image.memory(bytes, fit: BoxFit.cover);
  }

  static Future<Uint8List?> pickImage() async {
    final picker = ImagePicker();

    // 이미지 선택
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // 선택한 이미지를 Uint8List로 변환
      return await pickedImage.readAsBytes();
    }
    return null; // 이미지 선택 취소 시 null 반환
  }
}
