import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/doctor/doctor_profile/doctor_profile_screen.dart';
import 'package:grad_app/doctor/flagged.dart';
import 'package:grad_app/doctor/mass/mass_classification_screen.dart';
import 'package:grad_app/doctor/specify/specify_screen.dart';
import 'package:grad_app/doctor/viewed.dart';
import 'package:image_picker/image_picker.dart';

import 'doctor_states.dart';

class LayoutCubit extends Cubit<DoctorStates> {
  LayoutCubit() : super(DoctorInitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  List<String> titles = const [
    'Mass Classification',
    'Specific Classification',
    'Flagged',
    'Viewed',
    'Profile',
  ];
  List<Widget> pages = const [
    MassClassificationScreen(),
    SpecifyClassificationScreen(),
    Flagged(),
    Viewed(),
    DoctorProfileScreen(),
  ];
  int currentIndex = 0;

  void pageChange(int index) {
    currentIndex = index;
    emit(NavBarChangeState());
  }

  File? mriImage;
  File? generalImage;
  File? kneeImage;
  File? xRayImage;
  File? segmentationImage;
  File? detectionImage;
  ImagePicker mriPicker = ImagePicker();
  ImagePicker generalPicker = ImagePicker();
  ImagePicker kneePicker = ImagePicker();
  ImagePicker xRayPicker = ImagePicker();
  ImagePicker segmentationPicker = ImagePicker();
  ImagePicker detectionPicker = ImagePicker();

  Future<void> getRmiPhoto() async {
    final pickedFile = await mriPicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      mriImage = File(pickedFile.path);
      emit(ImagePickSuccessState());
    } else {
      emit(ImagePickErrorState());
    }
  }

  Future<void> takeRmiPhoto() async {
    final pickedFile = await mriPicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      mriImage = File(pickedFile.path);

      emit(ImagePickSuccessState());
    } else {
      if (kDebugMode) {}
      emit(ImagePickErrorState());
    }
  }

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

  Future<void> getSegmentation() async {
    final pickedFile =
        await segmentationPicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      segmentationImage = File(pickedFile.path);
      emit(ImagePickSuccessState());
    } else {
      emit(ImagePickErrorState());
    }
  }

  Future<void> takeSegmentation() async {
    final pickedFile =
        await segmentationPicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      segmentationImage = File(pickedFile.path);

      emit(ImagePickSuccessState());
    } else {
      if (kDebugMode) {}
      emit(ImagePickErrorState());
    }
  }

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

  Future<void> getXRay() async {
    final pickedFile = await xRayPicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      xRayImage = File(pickedFile.path);
      emit(ImagePickSuccessState());
    } else {
      emit(ImagePickErrorState());
    }
  }

  Future<void> takeXRay() async {
    final pickedFile = await xRayPicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      xRayImage = File(pickedFile.path);

      emit(ImagePickSuccessState());
    } else {
      if (kDebugMode) {}
      emit(ImagePickErrorState());
    }
  }

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
