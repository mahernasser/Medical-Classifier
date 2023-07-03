import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'states.dart';

class XRayCubit extends Cubit<XRayStates> {
  XRayCubit() : super(XRayInitialState());

  static XRayCubit get(context) => BlocProvider.of(context);

  File? xRayImage;

  ImagePicker segPicker = ImagePicker();

  Future<void> getXRay() async {
    final pickedFile = await segPicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      xRayImage = File(pickedFile.path);
      emit(ImagePickSuccessState());
    } else {
      emit(ImagePickErrorState());
    }
  }

  Future<void> takeXRay() async {
    final pickedFile = await segPicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      xRayImage = File(pickedFile.path);

      emit(ImagePickSuccessState());
    } else {
      if (kDebugMode) {}
      emit(ImagePickErrorState());
    }
  }
}
