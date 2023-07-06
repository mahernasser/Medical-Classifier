import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/components/default_button.dart';
import 'package:grad_app/doctor/image_picker/general/general_cubit.dart';
import 'package:grad_app/doctor/image_picker/general/general_states.dart';
import 'package:grad_app/resources/app_colors.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:image_picker/image_picker.dart';

class GeneralImagePicker extends StatelessWidget {
  const GeneralImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GeneralCubit(),
      child: BlocConsumer<GeneralCubit, GeneralStates>(
        builder: (context, state) {
          GeneralCubit cubit = GeneralCubit.get(context);
          return Scaffold(
            backgroundColor: AppColors.kDoctorPrimaryColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.kDoctorPrimaryColor,
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const Text(
                    'Hello doc, Please pick General image.',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 19),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  DefaultButton(
                    text: 'Attach Image',
                    color: AppColors.kDoctorSecondaryColor,
                    iconData: Icons.attach_file,
                    function: () {
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15)),
                          ),
                          context: context,
                          builder: (context) {
                            return Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15)),
                                color: AppColors.kDoctorSecondaryColor,
                              ),
                              height: MediaQuery.of(context).size.height * .22,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          border: GradientBoxBorder(
                                            gradient: LinearGradient(colors: [
                                              Colors.blue,
                                              Colors.red,
                                              Colors.blue,
                                              Colors.red,
                                            ]),
                                            width: 2,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        height: 65,
                                        width: 65,
                                        child: IconButton(
                                          alignment: Alignment.center,
                                          onPressed: () {
                                            cubit.chooseMyImage(
                                                source: ImageSource.camera);
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'Camera',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 80,
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          border: GradientBoxBorder(
                                            gradient: LinearGradient(colors: [
                                              Colors.blue,
                                              Colors.red,
                                              Colors.blue,
                                              Colors.red,
                                            ]),
                                            width: 2,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        height: 65,
                                        width: 65,
                                        child: IconButton(
                                          alignment: Alignment.center,
                                          onPressed: () {
                                            cubit.chooseMyImage(
                                                source: ImageSource.gallery);
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.image,
                                            color: Colors.white,
                                            size: 35,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'Gallery',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  cubit.generalImage != null
                      ? Container(
                          padding: const EdgeInsets.all(4.6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 2,
                                  color: AppColors.kDoctorSecondaryColor)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              cubit.generalImage!,
                              scale: 1.5,
                              height: MediaQuery.of(context).size.height * .38,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  ConditionalBuilder(
                    condition: cubit.generalImage != null,
                    fallback: (context) => const SizedBox(),
                    builder: (context) {
                      return SizedBox(
                        width: double.infinity,
                        height: 47,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo),
                            onPressed: () {
                              cubit.uploadImage();
                            },
                            child: ConditionalBuilder(
                              condition: state is! ImageUploadLoadingState,
                              builder: (context) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'SUBMIT',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Poppins',
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Icon(Icons.send_rounded),
                                ],
                              ),
                              fallback: (context) => const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is ImageUploadSuccessState) {
            // Fluttertoast.showToast(
            //     msg: 'Image has been Processed Successfully!',
            //     textColor: Colors.white,
            //     fontSize: 15,
            //     backgroundColor: AppColors.kDoctorPrimaryColor);
          }
        },
      ),
    );
  }
}
