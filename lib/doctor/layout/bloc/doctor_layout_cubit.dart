import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/doctor/doctor_profile/doctor_profile_screen.dart';
import 'package:grad_app/doctor/flagged.dart';
import 'package:grad_app/doctor/mass/mass_classification_screen.dart';
import 'package:grad_app/doctor/specify/specify_screen.dart';
import 'package:grad_app/doctor/viewed.dart';
import 'package:grad_app/models/classify.dart';
import 'package:image_picker/image_picker.dart';

import 'doctor_states.dart';

class LayoutCubit extends Cubit<DoctorStates> {
  final String userToken;
  List<String>? titles;
  List<Widget>? pages;
  LayoutCubit({Key? key, required this.userToken})
      : super(DoctorInitialState()) {
    List<String> titles = const [
      'Mass Classification',
      'Specific Classification',
      'Flagged',
      'Viewed',
      'Profile',
    ];
    List<Widget> pages = [
      MassClassificationScreen(
        userToken: userToken,
      ),
      SpecifyClassificationScreen(),
      Flagged(),
      Viewed(),
      DoctorProfileScreen(),
    ];
  }

  static LayoutCubit get(context) => BlocProvider.of(context);
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

  final dio = Dio();
  List<ClassifiedImage> classifiedImage = [];

  Future<void> getClassifiedImages() async {
    print('aa');
    Map<String, String> headers = {
      "Authorization":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0YTU1ZGEwOWRjYjI3ZDJiYTExZmRkZSIsImlhdCI6MTY4ODU5ODEwNn0.Tw28STVqyp3nmM_8maTELX8jY287UrfhbYn5rlhmCWQ"
    };
    final response = await dio.get(
      "http://10.0.2.2:8080/doctorClassified",
      options: Options(
        headers: headers,
        contentType: "application/json",
        receiveDataWhenStatusError: true,
      ),
    );
    Map<String, dynamic> json = jsonDecode(response.data.toString());
    if (response.statusCode == 200) {
      List<dynamic> data = json['data'];
      classifiedImage =
          data.map((item) => ClassifiedImage.fromJson(item)).toList();

      print(response.data["data"][0]["classification"]);
      print("=============");
      print(classifiedImage);
    } else {
      print("********");
      print(response.statusMessage);
    }
  }
}
