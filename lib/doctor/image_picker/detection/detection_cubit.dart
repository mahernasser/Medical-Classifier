import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'detection_states.dart';

class DetectionCubit extends Cubit<DetectionStates> {
  DetectionCubit() : super(DetectionInitialState());

  static DetectionCubit get(context) => BlocProvider.of(context);

  File? detectionImage;

  ImagePicker detectionPicker = ImagePicker();

  Future<void> getDetection() async {
    final pickedFile =
        await detectionPicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      detectionImage = File(pickedFile.path);
      emit(ImagePickSuccessState());
    } else {
      emit(ImagePickErrorState());
    }
  }

  Future<void> takeDetection() async {
    final pickedFile =
        await detectionPicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      detectionImage = File(pickedFile.path);

      emit(ImagePickSuccessState());
    } else {
      if (kDebugMode) {}
      emit(ImagePickErrorState());
    }
  }
}
