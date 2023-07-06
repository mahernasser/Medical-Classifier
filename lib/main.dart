import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_color_generator/material_color_generator.dart';

import '../cubit/home_cubit.dart';
import '../doctor/layout/bloc/doctor_layout_cubit.dart';
import '../doctor/layout/doctor_layout.dart';
import '../resources/app_colors.dart';
import '../views/login_screen.dart';
import '../views/register_screen.dart';
import '../views/report_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => LayoutCubit(userToken: ''),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const DoctorLayout(
          userData: {},
        ),
        routes: {
          ReportDetailsScreen.route: (context) => const ReportDetailsScreen(),
          LoginScreen.route: (context) => const LoginScreen(),
          RegisterScreen.route: (context) => const RegisterScreen(),
          //  '/': (context) => const HomeLayout(),
        },
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: generateMaterialColor(color: AppColors.kPrimaryColor),
        ),
      ),
    );
  }
}
