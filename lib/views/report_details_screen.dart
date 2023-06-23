import 'package:flutter/material.dart';
import 'package:grad_app/resources/app_colors.dart';
import 'package:grad_app/resources/app_images.dart';

class ReportDetailsScreen extends StatelessWidget {
  const ReportDetailsScreen({Key? key}) : super(key: key);

  static String route = 'report_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Details'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins',
          fontSize: 20,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        children: [
          Image.asset(AppImages.logo),
          const SizedBox(
            height: 18,
          ),
          const Text(
            'Dr Mostafa Classification :-',
            style: TextStyle(
              color: AppColors.kTitleColor,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 19,
            ),
          )
        ],
      ),
    );
  }
}
