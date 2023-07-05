import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'general_states.dart';

class GeneralCubit extends Cubit<GeneralStates> {
  GeneralCubit() : super(GeneralInitialState());

  static GeneralCubit get(context) => BlocProvider.of(context);

  XFile? generalImage; //variable for choosed file

  // ImagePicker generalPicker = ImagePicker();

  // Future<void> getGeneral() async {
  //   final pickedFile =
  //       await generalPicker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     generalImage = File(pickedFile.path);
  //     emit(ImagePickSuccessState());
  //   } else {
  //     emit(ImagePickErrorState());
  //   }
  // }
  //
  // Future<void> takeGeneral() async {
  //   final pickedFile =
  //       await generalPicker.pickImage(source: ImageSource.camera);
  //   if (pickedFile != null) {
  //     generalImage = File(pickedFile.path);
  //
  //     emit(ImagePickSuccessState());
  //   } else {
  //     if (kDebugMode) {}
  //     emit(ImagePickErrorState());
  //   }
  // }

  final dio = Dio();

  Future<void> uploadImage() async {
    emit(ImagePickLoadingState());
    try {
      Map<String, String> headers = {
        "Authorization":
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0YTU1ZGEwOWRjYjI3ZDJiYTExZmRkZSIsImlhdCI6MTY4ODU1OTAyN30.hd54QenqJP5hizLX3WpvWGNta8Wh6Mlf__p5mKVbbRQ"
      };

      final response = await dio.post(
        "http://10.0.2.2:8080/general",
        options: Options(
          headers: headers,
          contentType: "multipart/form-data",
          receiveDataWhenStatusError: true,
        ),
        data: FormData.fromMap(
          {
            "image": generalImage != null
                ? MultipartFile.fromFileSync(
                    generalImage!.path,
                    filename: generalImage!.path.split("/").last,
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
        generalImage = XFile(value.path);
        emit(ImagePickSuccessState());
      }
    });
  }
}
