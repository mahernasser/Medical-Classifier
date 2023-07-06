import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ImageDataSource {
  ImageDataSource();

  static Future<void> uploadImage(XFile image) async {
    final dio = Dio();
    final data = FormData()
      ..files.add(
        MapEntry(
          'image',
          MultipartFile.fromFileSync(
            image.path,
            filename: image.path.split(Platform.pathSeparator).last,
          ),
        ),
      );
    final result = await dio.fetch<Map<String, dynamic>>(
      Options(
        method: 'POST',
        contentType: 'multipart/form-data',
      ).compose(
        dio.options,
        "http://10.0.2.2:8080/general",
        data: data,
      ),
    );
    print('result.data ${result.data}');
  }
}
