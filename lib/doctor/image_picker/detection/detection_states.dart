abstract class DetectionStates {}

class DetectionInitialState extends DetectionStates {}

class NavBarChangeState extends DetectionStates {}

class ImagePickSuccessState extends DetectionStates {}

class UploadImageStates extends DetectionStates {}

class ImagePickLoadingState extends DetectionStates {}

class ImagePickErrorState extends DetectionStates {
  final String msg;

  ImagePickErrorState({required this.msg});
}
