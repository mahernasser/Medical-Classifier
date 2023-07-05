import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/cubit/app_states.dart';
import 'package:grad_app/cubit/home_cubit.dart';
import 'package:grad_app/resources/app_colors.dart';

import '../views/confirmed_request.dart';
import '../views/pending_requests.dart';
import '../views/scan_screen.dart';
import 'home_page.dart';
import 'profile_screen.dart';

class HomeLayout extends StatefulWidget {
  final Map<String, dynamic> userData;
  const HomeLayout({Key? key, required this.userData}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState(userData: userData);
}

class _HomeLayoutState extends State<HomeLayout> {
  final Map<String, dynamic> userData;
  List<Widget>? pages;
  List<String>? titles;

  _HomeLayoutState({required this.userData}) {
    List<Widget> pages = [
      HomePage(),
      PendingRequestsScreen(),
      ScanPage(userToken: userData['data']['token'],),
      ConfirmedRequestsScreen(),
      ProfileScreen(userData: {},),
    ];
    List<String> titles = const [
      "Home",
      'Pending Reports',
      'Classification',
      "Confirmed Reports",
      "Profile",
    ];
  }
  Widget currentPage = const HomePage();
  int currentIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, AppStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(titles![currentIndex]),
                titleTextStyle: const TextStyle(
                    color: AppColors.kPrimaryColor,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 20)),
            body: PageStorage(
              bucket: bucket,
              child: currentPage,
            ),
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              elevation: 10,
              notchMargin: 8,
              child: SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(
                              () {
                                currentPage = const HomePage();
                                currentIndex = 0;
                              },
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home_outlined,
                                color: currentIndex == 0
                                    ? AppColors.kPrimaryColor
                                    : Colors.grey,
                                size: 22,
                              ),
                              Text(
                                'Home',
                                style: TextStyle(
                                  color: currentIndex == 0
                                      ? AppColors.kPrimaryColor
                                      : Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(
                              () {
                                currentPage = const PendingRequestsScreen();
                                currentIndex = 1;
                              },
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.access_time,
                                color: currentIndex == 1
                                    ? AppColors.kPrimaryColor
                                    : Colors.grey,
                                size: 22,
                              ),
                              Text(
                                'Pending',
                                style: TextStyle(
                                    color: currentIndex == 1
                                        ? AppColors.kPrimaryColor
                                        : Colors.grey,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(
                              () {
                                currentPage = const ConfirmedRequestsScreen();
                                currentIndex = 3;
                              },
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.done,
                                color: currentIndex == 3
                                    ? AppColors.kPrimaryColor
                                    : Colors.grey,
                                size: 22,
                              ),
                              Text(
                                'Confirmed',
                                style: TextStyle(
                                  color: currentIndex == 3
                                      ? AppColors.kPrimaryColor
                                      : Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(
                              () {
                                currentPage = ProfileScreen(userData: userData,);
                                currentIndex = 4;
                              },
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_outline,
                                color: currentIndex == 4
                                    ? AppColors.kPrimaryColor
                                    : Colors.grey,
                                size: currentIndex == 4 ? 24 : 22,
                              ),
                              Text(
                                'Profile',
                                style: TextStyle(
                                    color: currentIndex == 4
                                        ? AppColors.kPrimaryColor
                                        : Colors.grey,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              elevation: 15,
              backgroundColor: Colors.indigo,
              child: Image.asset(
                'assets/images/mri.png',
                color: currentIndex == 2 ? Colors.white : Colors.grey,
                scale: 12,
              ),
              onPressed: () {
                setState(() {
                  currentIndex = 2;
                  currentPage = ScanPage(userToken: userData['data']['id'],);
                });
              },
            ),
          );
        },
        listener: (context, state) {});
  }
}
