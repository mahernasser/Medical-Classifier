import 'package:flutter/material.dart';
import 'package:grad_app/resources/app_colors.dart';
import 'package:grad_app/resources/app_images.dart';
import 'package:grad_app/views/login_screen.dart';

import '../../components/custom_row.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff392850),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 22),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage(AppImages.patient),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Dr. Ahmed grad_app',
                          style: TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          "35 years old",
                          style: TextStyle(
                            // color: AppColors.kPrimaryColor,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 22),
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.call_outlined,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '01067897023',
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 22),
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Ahmedgrad_app@gmail.com',
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Expanded(
              //       child: Container(
              //         height: 80,
              //         width: MediaQuery.of(context).size.width * .41,
              //         decoration: BoxDecoration(
              //             border: Border.all(color: Colors.white, width: .6)),
              //         child: Center(
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: const [
              //               Text(
              //                 '15',
              //                 style: TextStyle(
              //                   color: AppColors.kPrimaryColor,
              //                   fontSize: 18,
              //                   height: .98,
              //                   fontFamily: 'Poppins',
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //               Text(
              //                 'Classifications',
              //                 style: TextStyle(
              //                     color: AppColors.kBorderColor,
              //                     fontSize: 18,
              //                     fontFamily: 'Poppins',
              //                     fontWeight: FontWeight.w500),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         height: 80,
              //         decoration: BoxDecoration(
              //             border: Border.all(color: Colors.grey, width: .8)),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: const [
              //             Text(
              //               'Dr. Smith',
              //               style: TextStyle(
              //                 color: AppColors.kPrimaryColor,
              //                 fontSize: 17,
              //                 height: .98,
              //                 fontFamily: 'Poppins',
              //                 fontWeight: FontWeight.w500,
              //               ),
              //             ),
              //             Text(
              //               'Current Doctor',
              //               style: TextStyle(
              //                   color: AppColors.kBorderColor,
              //                   fontSize: 18,
              //                   fontFamily: 'Poppins',
              //                   fontWeight: FontWeight.w500),
              //             ),
              //             // Image.asset(
              //             //   AppImages.drIcon,
              //             //   scale: 8,
              //             // )
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 22),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: const [
                      Icon(
                        Icons.settings,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Settings',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 1.5,
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 22),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: const [
                      Icon(
                        Icons.attachment_sharp,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Promotions',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              const Divider(
                thickness: 1.5,
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 22),
                child: CustomRow(
                  textColor: AppColors.kSecondryColor,
                  imageColor: AppColors.kSecondryColor,
                  text: 'Log Out',
                  image: AppImages.logout,
                  function: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const LoginScreen();
                    }));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
