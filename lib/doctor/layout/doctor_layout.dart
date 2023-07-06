import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_app/doctor/layout/bloc/doctor_layout_cubit.dart';
import 'package:grad_app/doctor/layout/bloc/doctor_states.dart';

class DoctorLayout extends StatelessWidget {
  final Map<String, dynamic> userData;
  const DoctorLayout({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, DoctorStates>(
      builder: (context, state) {
        LayoutCubit cubit = LayoutCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color(0xff392850),
            title: Text(cubit.titles![cubit.currentIndex]),
          ),
          body: cubit.pages![cubit.currentIndex],
          bottomNavigationBar: ConvexAppBar(
            backgroundColor: const Color(0xff392850),
            elevation: 6,
            onTap: cubit.pageChange,
            items: [
              TabItem(
                  icon: Icon(
                    Icons.apps,
                    color: cubit.currentIndex == 0
                        ? const Color(0xff392850)
                        : Colors.white,
                  ),
                  title: 'Mass'),
              TabItem(
                  icon: Icon(
                    Icons.widgets_outlined,
                    color: cubit.currentIndex == 1
                        ? const Color(0xff392850)
                        : Colors.white,
                  ),
                  title: 'Specific'),
              TabItem(
                  icon: Icon(
                    Icons.flag,
                    color: cubit.currentIndex == 2
                        ? const Color(0xff392850)
                        : Colors.white,
                  ),
                  title: 'Flagged'),
              TabItem(
                  icon: Icon(
                    Icons.table_view_outlined,
                    color: cubit.currentIndex == 3
                        ? const Color(0xff392850)
                        : Colors.white,
                  ),
                  title: 'Viewed'),
              TabItem(
                  icon: Icon(
                    Icons.person_outline,
                    color: cubit.currentIndex == 4
                        ? const Color(0xff392850)
                        : Colors.white,
                  ),
                  title: 'Profile'),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
