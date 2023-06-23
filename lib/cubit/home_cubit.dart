import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'app_states.dart';

class HomeCubit extends Cubit<AppStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  File? mriImage;
  ImagePicker picker = ImagePicker();
  Future<void> getRmiPhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      mriImage = File(pickedFile.path);
      emit(ImagePickSuccessState());
    } else {
      print('No selected Images');
      emit(ImagePickErrorState());
    }
  }

  Future<void> takeRmiPhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      mriImage = File(pickedFile.path);
      print(mriImage?.path.split("/").last);

      emit(ImagePickSuccessState());
    } else {
      if (kDebugMode) {
        print('No selected Images');
      }
      emit(ImagePickErrorState());
    }
  }
}
