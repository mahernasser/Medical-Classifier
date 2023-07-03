import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'general_states.dart';

class GeneralCubit extends Cubit<GeneralStates> {
  GeneralCubit() : super(GeneralInitialState());

  static GeneralCubit get(context) => BlocProvider.of(context);

  File? generalImage;

  ImagePicker generalPicker = ImagePicker();

  Future<void> getGeneral() async {
    final pickedFile =
        await generalPicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      generalImage = File(pickedFile.path);
      emit(ImagePickSuccessState());
    } else {
      emit(ImagePickErrorState());
    }
  }

  Future<void> takeGeneral() async {
    final pickedFile =
        await generalPicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      generalImage = File(pickedFile.path);

      emit(ImagePickSuccessState());
    } else {
      if (kDebugMode) {}
      emit(ImagePickErrorState());
    }
  }
}
