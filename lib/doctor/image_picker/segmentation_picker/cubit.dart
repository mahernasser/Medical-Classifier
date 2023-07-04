import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'states.dart';

class SegmentationCubit extends Cubit<SegmentationStates> {
  SegmentationCubit() : super(SegmentationInitialState());

  static SegmentationCubit get(context) => BlocProvider.of(context);

  File? segmentationImage;

  ImagePicker segPicker = ImagePicker();

  Future<void> getSegmentation() async {
    final pickedFile = await segPicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      segmentationImage = File(pickedFile.path);
      emit(ImagePickSuccessState());
    } else {
      emit(ImagePickErrorState());
    }
  }

  Future<void> takeSegmentation() async {
    final pickedFile = await segPicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      segmentationImage = File(pickedFile.path);

      emit(ImagePickSuccessState());
    } else {
      if (kDebugMode) {}
      emit(ImagePickErrorState());
    }
  }
}
