import 'dart:io';

import 'package:flutter/cupertino.dart';
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

  File? image;
  ImagePicker picker = ImagePicker();

  Future<void> getRmiPhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(ImagePickSuccessState());
    } else {
      emit(ImagePickErrorState());
    }
  }

  Future<void> takeRmiPhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(ImagePickSuccessState());
    } else {
      emit(ImagePickErrorState());
    }
  }
}
