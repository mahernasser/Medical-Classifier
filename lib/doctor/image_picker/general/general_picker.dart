import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/components/default_button.dart';
import 'package:grad_app/doctor/image_picker/general/general_cubit.dart';
import 'package:grad_app/doctor/image_picker/general/general_states.dart';
import 'package:grad_app/resources/app_colors.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GeneralImagePicker extends StatelessWidget {
  final String userToken;
  const GeneralImagePicker({Key? key, required this.userToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>GeneralCubit(),
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
                        fontFamily: 'Poppins', color: Colors.white, fontSize: 19),
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                            cubit.takeGeneral();
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
                                            cubit.getGeneral();
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
                  ConditionalBuilder(
                    condition: cubit.generalImage != null,
                    fallback: (context) => const SizedBox(),
                    builder: (context) {
                      return DefaultButton(
                          text: 'Submit', iconData: Icons.send, function: () async {
                            String url = "http://localhost:8080/general";
                            Uri uri = Uri.parse(url);
                            var header = {
                              'Authorization': userToken
                            };
                            var body = {
                              'image': cubit.generalImage
                            };
                            var response = await http.post(
                              uri,
                              headers: header,
                              body: body
                            );
                            Map<String, dynamic> responseBody = jsonDecode(response.body);
                            print(responseBody);
                            /*
                                  Input data for testing is:
                                  image = /C:/Users/oem/Downloads/Medical_Imaging_API's/Classification_General/images/TCGA_HT_8563_19981209_9_.jpg

                                  Output(responseBody) should be like this:
                                  {
                                    "status": "true",
                                    "message: ": "Classified Images Successfully!",
                                    "data: ": [
                                                {
                                                  "id": "6453d7f5b42c3c56eccc3a5f",
                                                  "image": "uploads\\image-1683216373377-10703109.jpg"
                                                },
                                                {
                                                  "id": "6453d7f5b42c3c56eccc3a61",
                                                  "image": "uploads\\image-1683216373377-921706813.jpg"
                                                },
                                                {
                                                  "id": "6453d7f5b42c3c56eccc3a63",
                                                  "image": "uploads\\image-1683216373378-793287055.jpg"
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
