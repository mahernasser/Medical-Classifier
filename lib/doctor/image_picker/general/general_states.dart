abstract class GeneralStates {}

class GeneralInitialState extends GeneralStates {}

class NavBarChangeState extends GeneralStates {}

class ImagePickSuccessState extends GeneralStates {}

class UploadImageStates extends GeneralStates {}

class ImagePickLoadingState extends GeneralStates {}

class ImagePickErrorState extends GeneralStates {
  final String msg;

  ImagePickErrorState({required this.msg});
}
