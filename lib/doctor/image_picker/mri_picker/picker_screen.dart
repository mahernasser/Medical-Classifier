import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/components/default_button.dart';
import 'package:grad_app/doctor/image_picker/mri_picker/states.dart';
import 'package:grad_app/resources/app_colors.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import 'cubit.dart';

class MriImagePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MriCubit(),
      child: BlocConsumer<MriCubit, MriStates>(
        builder: (context, state) {
          MriCubit cubit = MriCubit.get(context);
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
                    'Hello doc, Please pick Mri image.',
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
                                            cubit.takeMri();
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
                                            cubit.getMri();
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
                  cubit.mriImage != null
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
                              cubit.mriImage!,
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
                    height: 10,
                  ),
                  ConditionalBuilder(
                    condition: cubit.mriImage != null,
                    fallback: (context) => const SizedBox(),
                    builder: (context) {
                      return DefaultButton(
                          text: 'Submit',
                          iconData: Icons.send,
                          function: () async {
                            /*
                                  Input data for testing is:
                                  image = /C:/Users/oem/Downloads/Medical_Imaging_API's/Classification_MRI/images/1143_coronal_MRI_Knee.jpg,/C:/Users/oem/Downloads/Medical_Imaging_API's/Classification_MRI/images/TCGA_HT_8563_19981209_11_.jpg

                                  Output(responseBody) should be like this:
                                  {
                                    "status": "true",
                                    "message: ": "Classified Images Successfully!",
                                    "data: ": [
                                                {
                                                  "id": "6453d826b42c3c56eccc3a76",
                                                  "image": "uploads\\image-1683216422422-570750201.jpg"
                                                },
                                                {
                                                  "id": "6453d826b42c3c56eccc3a78",
                                                  "image": "uploads\\image-1683216422422-627957460.jpg"
                                                }
                                              ]
                                  }
                            */
                          });
                    },
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
