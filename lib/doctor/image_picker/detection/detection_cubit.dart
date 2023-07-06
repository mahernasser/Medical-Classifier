import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import 'detection_states.dart';

class DetectionCubit extends Cubit<DetectionStates> {
  DetectionCubit() : super(DetectionInitialState());

  static DetectionCubit get(context) => BlocProvider.of(context);

  File? detectionImage;

  ImagePicker detectionPicker = ImagePicker();

  final dio = Dio();

  Future<void> uploadImage() async {
    try {
      Map<String, String> headers = {
        "Authorization":
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0YTU1ZGEwOWRjYjI3ZDJiYTExZmRkZSIsImlhdCI6MTY4ODU1OTAyN30.hd54QenqJP5hizLX3WpvWGNta8Wh6Mlf__p5mKVbbRQ"
      };
      final response = await dio.post(
        "http://10.0.2.2:8080/objectDetection",
        options: Options(
          headers: headers,
          contentType: "multipart/form-data",
          receiveDataWhenStatusError: true,
        ),
        data: FormData.fromMap(
          {
            "image": detectionImage != null
                ? MultipartFile.fromFileSync(
                    detectionImage!.path,
                    filename: detectionImage!.path.split("/").last,
                    contentType: MediaType('image', 'jpeg'),
                  )
                : null,
          },
        ),
      );
      if (response.data["status"] == "true" && response.statusCode == 200) {
        emit(UploadImageStates());
        print(response.data);
      } else {
        emit(ImagePickErrorState(msg: "${response.data["status"]}"));
        print(response.data);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        emit(ImagePickErrorState(msg: "$e"));
      } else if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        emit(ImagePickErrorState(msg: "$e"));
      } else if (e.type == DioExceptionType.badResponse) {
        emit(ImagePickErrorState(msg: "$e"));
      } else {
        emit(ImagePickErrorState(msg: "$e"));
      }
    } catch (e) {
      emit(ImagePickErrorState(msg: "$e"));
      print(e);
    }
  }

  chooseMyImage({ImageSource? source}) {
    ImagePicker.platform.getImage(source: source!).then((value) {
      if (value != null) {
        detectionImage = File(value.path);
        emit(ImagePickSuccessState());
      }
    });
  }
}
