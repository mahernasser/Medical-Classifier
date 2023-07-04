import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import '../components/default_button.dart';
import '../cubit/app_states.dart';
import '../cubit/home_cubit.dart';
import '../resources/app_colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScanPage extends StatefulWidget {
  String userToken = '';
  ScanPage({Key? key, required this.userToken}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState(userToken: userToken);
}

class _ScanPageState extends State<ScanPage> {
  List<String> doctors = [
    "Dr. Smith",
    "Dr. Johnson",
    "Dr. Lee",
    "Dr. Kim",
  ];
  String? selectedDoctorValue;
  final String userToken;
  _ScanPageState({required this.userToken});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, AppStates>(
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cubit.mriImage != null
                        ? Container(
                            padding: const EdgeInsets.all(4.6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 2, color: AppColors.kPrimaryColor)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                cubit.mriImage!,
                                scale: 1.5,
                                height:
                                    MediaQuery.of(context).size.height * .38,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          )
                        : Container(
                            height: 380,
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    DefaultButton(
                        text: 'Attach Image',
                        iconData: Icons.attach_file,
                        function: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor:
                                      AppColors.kPrimaryColor.withOpacity(0.95),
                                  title: const Text(
                                    'Choose Image:',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontFamily: 'poppins',
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  alignment: Alignment.center,
                                  content: Padding(
                                    padding: const EdgeInsets.all(30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                border: GradientBoxBorder(
                                                  gradient:
                                                      LinearGradient(colors: [
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
                                                  cubit.takeRmiPhoto();
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
                                          width: 40,
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                border: GradientBoxBorder(
                                                  gradient:
                                                      LinearGradient(colors: [
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
                                                  cubit.getRmiPhoto();
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
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Poppins'),
                                        ))
                                  ],
                                );
                              });
                        }),
                    const SizedBox(
                      height: 15,
                    ),
                    ExpansionTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      collapsedBackgroundColor: AppColors.kPrimaryColor,
                      textColor: Colors.white,
                      collapsedIconColor: Colors.white,
                      collapsedTextColor: Colors.white,
                      backgroundColor: AppColors.kPrimaryColor,
                      title: Text(
                          selectedDoctorValue == null
                              ? "Select a doctor"
                              : selectedDoctorValue!,
                          style: const TextStyle(fontFamily: 'Poppins')),
                      children: doctors.map((doctor) {
                        return ListTile(
                          title: Text(
                            doctor,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              selectedDoctorValue = doctor;
                            });
                          },
                          selected: selectedDoctorValue == doctor,
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ConditionalBuilder(
                        condition: cubit.mriImage != null &&
                            selectedDoctorValue != null,
                        builder: (context) {
                          return Align(
                            alignment: Alignment.centerRight,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    width: 2.0, color: AppColors.kPrimaryColor),
                              ),
                              onPressed: () async {
                                String url = "http://localhost:8080/uploadPatientImage";
                                Uri uri = Uri.parse(url);
                                var header = {
                                  'Authorization': userToken
                                };
                                var body = {
                                  'image': cubit.mriImage,
                                  'doctor_username': selectedDoctorValue
                                };
                                var response = await http.post(
                                  uri,
                                  headers: header,
                                  body: body
                                );
                                Map<String, dynamic> responseBody = jsonDecode(response.body);
                                if(responseBody['status'] == "true"){
                                MotionToast.success(
                                        title: const Text('Success'),
                                        position: MotionToastPosition.top,
                                        description: const Text(
                                            'We will response as soon as possible'))
                                    .show(context);
                                }
                                print(responseBody);
                                /*
                                  Input data for testing is:
                                  image = /C:/Users/oem/Downloads/Medical_Imaging_API's/Classification_General/images/0X32DC806BF959BA14_Sonar_Heart.jpg
                                  doctor_username = mostafa14
                                  
                                  Output(responseBody) should be like this:
                                  {
                                     "status": "true",
                                     "message: ": "Logged in successfully!",
                                     "data: ": {
                                                 "status": "true",
                                                 "message": "Image uploaded successfully",
                                                 "data": {
                                                      "image": "uploads\\image-1683216732312-209130043.jpg",
                                                      "id": "6453d95cb42c3c56eccc3ab4"
                                                      }
                                                }
                                  }
                                  */
                              },
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                    color: AppColors.kPrimaryColor,
                                    fontSize: 15),
                              ),
                            ),
                          );
                        },
                        fallback: (context) {
                          return const SizedBox();
                        })
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
