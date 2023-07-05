import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'knee_states.dart';

class KneeCubit extends Cubit<KneeStates> {
  KneeCubit() : super(KneeInitialState());

  static KneeCubit get(context) => BlocProvider.of(context);

  File? kneeImage;

  ImagePicker kneePicker = ImagePicker();

  Future<void> getKnee() async {
    final pickedFile = await kneePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      kneeImage = File(pickedFile.path);
      emit(ImagePickSuccessState());
    } else {
      emit(ImagePickErrorState());
    }
  }

  Future<void> takeKnee() async {
    final pickedFile = await kneePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      kneeImage = File(pickedFile.path);

      emit(ImagePickSuccessState());
    } else {
      if (kDebugMode) {}
      emit(ImagePickErrorState());
    }
  }
}
